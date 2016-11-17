
## Analysis script for HIV risk compensation paper

suppressMessages(library(EpiModelHIV))
source("analysis/fx.R")

# scp hyak:/gscratch/csde/camp/data/save/*.rda data/

steps <- 52 *  10

## Base model: sim.n2000
load("data/sim.n2000.rda")
sim.base <- truncate_sim(sim, at = 2600)

mn <- as.data.frame(sim.base)
ql <- as.data.frame(sim.base, out = "qnt", qval = 0.05)
qu <- as.data.frame(sim.base, out = "qnt", qval = 0.95)

# prevalence
round(data.frame(mean = mn$i.prev[steps],
                 ql = ql$i.prev[steps], qu = qu$i.prev[steps]), 3)

# incidence
round(data.frame(
  mean = (mean(tail(mn$incid, 100)) /
            ((1 - mean(tail(mn$i.prev, 100))) * mean(tail(mn$num, 100)))) * 52 * 100,
  ql = (mean(tail(ql$incid, 100)) /
          ((1 - mean(tail(ql$i.prev, 100))) * mean(tail(ql$num, 100)))) * 52 * 100,
  qu = (mean(tail(qu$incid, 100)) /
          ((1 - mean(tail(qu$i.prev, 100))) * mean(tail(qu$num, 100)))) * 52 * 100), 2)

ir.base <- (sum(mn$incid)/sum((1 - mn$i.prev) * mn$num)) * 52 * 1e5
ir.base

incid.base <- sum(mn$incid)
incid.base


## No Risk Comp
load("data/sim.n2100.rda")
epi_stats(sim, ir.base, incid.base)

## 100% risk comp, all MSM
load("data/sim.n2143.rda")
epi_stats(sim, ir.base, incid.base)

load("data/sim.n2132.rda")
epi_stats(sim, ir.base, incid.base)


# Poisson model -----------------------------------------------------------
# for the figure

fn <- list.files("data/", pattern = "21[0-9][0-9]", full.names = TRUE)
df <- data.frame(rcomp = NA, adr = NA, cov = NA, incid = NA,
                 offst = NA, ir = NA, pia = NA,
                 mtrans = NA, mtrans.p1 = NA, mtrans.p0 = NA, ptop = NA)

for (i in 1:length(fn)) {
  load(fn[i])
  rcomp <- rep(sim$param$rcomp.prob, sim$control$nsims)
  if (identical(sim$param$rcomp.adh.groups, 0:3)) {
    adr <- 0
  }
  if (identical(sim$param$rcomp.adh.groups, 1:3)) {
    adr <- 1
  }
  if (identical(sim$param$rcomp.adh.groups, 2:3)) {
    adr <- 2
  }
  if (identical(sim$param$rcomp.adh.groups, 3)) {
    adr <- 3
  }
  adr <- rep(adr, sim$control$nsims)
  cov <- rep(sim$param$prep.coverage, sim$control$nsims)
  sim <- truncate_sim(sim, at = 2600)$epi
  incid <- unname(colSums(tail(sim$incid, 100)))
  offst <- unname(colSums((1 - tail(sim$i.prev, 100)) * tail(sim$num, 100)))
  ir <- (incid/offst) * 5200
  num.comp <- unname(colSums(sim$incid))
  denom.comp <- unname(colSums((1 - sim$i.prev) * sim$num))
  ir.comp <- (num.comp / denom.comp) * 5200
  pia <- ((ir.base/1000) - ir.comp)/(ir.base/1000)

  mtrans <- unname(colMeans(sim$mean.trans, na.rm = TRUE)) * 1000
  mtrans.p1 <- unname(colMeans(sim$mean.trans.prep, na.rm = TRUE)) * 1000
  mtrans.p0 <- unname(colMeans(sim$mean.trans.nprep, na.rm = TRUE)) * 1000
  offst <- unname(colSums((1 - sim$i.prev) * sim$num))
  ptop <- unname(colSums(sim$prepCurr)) / offst

  dft <- data.frame(rcomp, adr, cov, incid, offst, ir, pia,
                    mtrans, mtrans.p1, mtrans.p0, ptop)
  df <- rbind(df, dft)
  cat("*")
}
df <- df[-1, ]

table(df$adr, df$cov)

par(mfrow = c(1,1), mar = c(3,3,1,1), mgp = c(2,1,0))
boxplot(ir ~ rcomp*adr, data = df, col = "bisque", outline = FALSE)
boxplot(mtrans ~ rcomp*adr, data = df, col = "bisque", outline = FALSE)
boxplot(mtrans.p1 ~ rcomp*adr, data = df, col = "bisque", outline = FALSE)
boxplot(mtrans.p0 ~ rcomp*adr, data = df, col = "bisque", outline = FALSE)
boxplot(ptop ~ rcomp*adr, data = df, col = "bisque", outline = FALSE)

head(df)

pseq <- seq(0, 1, 0.1)
palette(adjustcolor(RColorBrewer::brewer.pal(5, "Set1"), alpha.f = 0.75))

# Figure 1 ------------------------------------------------------------

tiff(file = "../Figure1.tiff", height = 1227, width = 2250, units = "px", res = 300, pointsize = 8)
par(mfrow = c(1,2), mar = c(3,3,2,1), mgp = c(2,1,0))

# Incidence rate
mod <- loess(ir ~ rcomp*adr, data = df)

nd0 <- expand.grid(rcomp = pseq, adr = 0, offst = 5200)
nd1 <- expand.grid(rcomp = pseq, adr = 1, offst = 5200)
nd2 <- expand.grid(rcomp = pseq, adr = 2, offst = 5200)
nd3 <- expand.grid(rcomp = pseq, adr = 3, offst = 5200)
pred0 <- predict(mod, newdata = nd0, type = "response")
pred1 <- predict(mod, newdata = nd1, type = "response")
pred2 <- predict(mod, newdata = nd2, type = "response")
pred3 <- predict(mod, newdata = nd3, type = "response")
strt <- mean(c(pred0[1], pred1[1], pred2[1], pred3[1]))

plot(x = pseq, y = pred0, type = "n", lwd = 1, pch = 20, ylim = c(1.9, 2.4),
     main = "A. HIV Incidence Rate", col = 1, ylab = "IR per 100 PYAR",
     xlab = "Relative Increase in Risk Compensation", bty = "n")
grid()
abline(h = strt, lty = 2, col = "grey40")
lines(x = pseq, y = pred0, col = 1, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred1, col = 2, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred2, col = 3, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred3, col = 4, lwd = 1, type = "b", pch = 20, cex = 0.9)
legend("topleft", legend = c("Hi/Med/Low/Non Adr", "Hi/Med/Low Adr", "Hi/Med Adr", "Hi Adr", "Base (Ref)"),
       lty = c(1, 1, 1, 1, 2), col = c(1:4, "grey40"), lwd = 2, cex = 0.9, bty = "n")

# PIA
mod <- loess(pia ~ rcomp*adr, data = df)

nd0 <- expand.grid(rcomp = pseq, adr = 0)
nd1 <- expand.grid(rcomp = pseq, adr = 1)
nd2 <- expand.grid(rcomp = pseq, adr = 2)
nd3 <- expand.grid(rcomp = pseq, adr = 3)
pred0 <- predict(mod, newdata = nd0, type = "response")
pred1 <- predict(mod, newdata = nd1, type = "response")
pred2 <- predict(mod, newdata = nd2, type = "response")
pred3 <- predict(mod, newdata = nd3, type = "response")
strt <- mean(c(pred0[1], pred1[1], pred2[1], pred3[1]))

par(mar = c(3,3,2,1), mgp = c(2,1,0))
plot(x = pseq, y = pred0, type = "n", lwd = 1, pch = 20, ylim = c(0.25, 0.4),
     main = "B. Percent of Infections Averted", col = 1, bty = "n",
     ylab = "PIA", xlab = "Relative Increase in Risk Compensation")
grid()
abline(h = strt, lty = 2, col = "grey40")
lines(x = pseq, y = pred0, col = 1, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred1, col = 2, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred2, col = 3, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred3, col = 4, lwd = 1, type = "b", pch = 20, cex = 0.9)
legend("topleft", legend = c("Hi/Med/Low/Non Adr", "Hi/Med/Low Adr", "Hi/Med Adr", "Hi Adr", "Base (Ref)"),
       lty = c(1, 1, 1, 1, 2), col = c(1:4, "grey40"), lwd = 2, cex = 0.9, bty = "n")

dev.off()


# Figure 2 ------------------------------------------------------------

tiff(file = "../Figure2.tiff", height = 2250, width = 2250, units = "px", res = 300, pointsize = 8)
par(mfrow = c(2,2), mar = c(3,3,2,1), mgp = c(2,1,0))

mod <- loess(mtrans ~ rcomp*adr, data = df)
nd0 <- expand.grid(rcomp = pseq, adr = 0)
nd1 <- expand.grid(rcomp = pseq, adr = 1)
nd2 <- expand.grid(rcomp = pseq, adr = 2)
nd3 <- expand.grid(rcomp = pseq, adr = 3)
pred0 <- predict(mod, newdata = nd0, type = "response")
pred1 <- predict(mod, newdata = nd1, type = "response")
pred2 <- predict(mod, newdata = nd2, type = "response")
pred3 <- predict(mod, newdata = nd3, type = "response")
strt <- mean(c(pred0[1], pred1[1], pred2[1], pred3[1]))

plot(x = pseq, y = pred0, type = "n", lwd = 1, pch = 20, ylim = c(1.5, 2.0),
     main = "A. Individual Risk Overall", col = 1, bty = "n",
     ylab = "Transmissions per 1000 Exposures", xlab = "Relative Increase in Risk Compensation")
grid()
abline(h = strt, lty = 2, col = "grey40")
lines(x = pseq, y = pred0, col = 1, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred1, col = 2, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred2, col = 3, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred3, col = 4, lwd = 1, type = "b", pch = 20, cex = 0.9)
legend("topleft", legend = c("Hi/Med/Low/Non Adr", "Hi/Med/Low Adr", "Hi/Med Adr", "Hi Adr", "Base (Ref)"),
       lty = c(1, 1, 1, 1, 2), col = c(1:4, "grey40"), lwd = 2, cex = 0.9, bty = "n")


mod <- loess(mtrans.p1 ~ rcomp*adr, data = df)
nd0 <- expand.grid(rcomp = pseq, adr = 0)
nd1 <- expand.grid(rcomp = pseq, adr = 1)
nd2 <- expand.grid(rcomp = pseq, adr = 2)
nd3 <- expand.grid(rcomp = pseq, adr = 3)
pred0 <- predict(mod, newdata = nd0, type = "response")
pred1 <- predict(mod, newdata = nd1, type = "response")
pred2 <- predict(mod, newdata = nd2, type = "response")
pred3 <- predict(mod, newdata = nd3, type = "response")
strt <- mean(c(pred0[1], pred1[1], pred2[1], pred3[1]))

plot(x = pseq, y = pred0, type = "n", lwd = 1, pch = 20, ylim = c(0.4, 1.2),
     main = "B. Individual Risk for PrEP Users", col = 1, bty = "n",
     ylab = "Transmissions per 1000 Exposures", xlab = "Relative Increase in Risk Compensation")
grid()
abline(h = strt, lty = 2, col = "grey40")
lines(x = pseq, y = pred0, col = 1, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred1, col = 2, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred2, col = 3, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred3, col = 4, lwd = 1, type = "b", pch = 20, cex = 0.9)
legend("topleft", legend = c("Hi/Med/Low/Non Adr", "Hi/Med/Low Adr", "Hi/Med Adr", "Hi Adr", "Base (Ref)"),
       lty = c(1, 1, 1, 1, 2), col = c(1:4, "grey40"), lwd = 2, cex = 0.9, bty = "n")


mod <- loess(mtrans.p0 ~ rcomp*adr, data = df)
nd0 <- expand.grid(rcomp = pseq, adr = 0)
nd1 <- expand.grid(rcomp = pseq, adr = 1)
nd2 <- expand.grid(rcomp = pseq, adr = 2)
nd3 <- expand.grid(rcomp = pseq, adr = 3)
pred0 <- predict(mod, newdata = nd0, type = "response")
pred1 <- predict(mod, newdata = nd1, type = "response")
pred2 <- predict(mod, newdata = nd2, type = "response")
pred3 <- predict(mod, newdata = nd3, type = "response")
strt <- mean(c(pred0[1], pred1[1], pred2[1], pred3[1]))

plot(x = pseq, y = pred0, type = "n", lwd = 1, pch = 20, ylim = c(2.2, 2.32),
     main = "C. Individual Risk for PrEP Non-Users", col = 1, bty = "n",
     ylab = "Transmissions per 1000 Exposures", xlab = "Relative Increase in Risk Compensation")
grid()
abline(h = strt, lty = 2, col = "grey40")
lines(x = pseq, y = pred0, col = 1, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred1, col = 2, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred2, col = 3, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred3, col = 4, lwd = 1, type = "b", pch = 20, cex = 0.9)
legend("topleft", legend = c("Hi/Med/Low/Non Adr", "Hi/Med/Low Adr", "Hi/Med Adr", "Hi Adr", "Base (Ref)"),
       lty = c(1, 1, 1, 1, 2), col = c(1:4, "grey40"), lwd = 2, cex = 0.9, bty = "n")


mod <- loess(ptop ~ rcomp*adr, data = df)
nd0 <- expand.grid(rcomp = pseq, adr = 0)
nd1 <- expand.grid(rcomp = pseq, adr = 1)
nd2 <- expand.grid(rcomp = pseq, adr = 2)
nd3 <- expand.grid(rcomp = pseq, adr = 3)
pred0 <- predict(mod, newdata = nd0, type = "response") * 100
pred1 <- predict(mod, newdata = nd1, type = "response") * 100
pred2 <- predict(mod, newdata = nd2, type = "response") * 100
pred3 <- predict(mod, newdata = nd3, type = "response") * 100
strt <- mean(c(pred0[1], pred1[1], pred2[1], pred3[1]))

plot(x = pseq, y = pred0, type = "n", lwd = 1, pch = 20, ylim = c(24, 32),
     main = "D. Person-Time on PrEP", col = 1, bty = "n",
     ylab = "On PrEP per 100 Susceptible Person-Weeks", xlab = "Relative Increase in Risk Compensation")
grid()
abline(h = strt, lty = 2, col = "grey40")
lines(x = pseq, y = pred0, col = 1, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred1, col = 2, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred2, col = 3, lwd = 1, type = "b", pch = 20, cex = 0.9)
lines(x = pseq, y = pred3, col = 4, lwd = 1, type = "b", pch = 20, cex = 0.9)
legend("topleft", legend = c("Hi/Med/Low/Non Adr", "Hi/Med/Low Adr", "Hi/Med Adr", "Hi Adr", "Base (Ref)"),
       lty = c(1, 1, 1, 1, 2), col = c(1:4, "grey40"), lwd = 2, cex = 0.9, bty = "n")

dev.off()


# Table 1 - Population Level Outcomes -----------------------------------------------

# Base scenario
load("data/sim.n2100.rda")
epi_stats(sim, ir.base, incid.base)

# High adherence, 50% RC
load("data/sim.n2105.rda")
epi_stats(sim, ir.base, incid.base)

# High adherence, 100% RC
load("data/sim.n2110.rda")
epi_stats(sim, ir.base, incid.base)


# High/moderate adherence, 50% RC
load("data/sim.n2116.rda")
epi_stats(sim, ir.base, incid.base)

# High/moderate adherence, 100% RC
load("data/sim.n2121.rda")
epi_stats(sim, ir.base, incid.base)


# High/moderate/low adherence, 50% RC
load("data/sim.n2127.rda")
epi_stats(sim, ir.base, incid.base)

# High/moderate/low adherence, 100% RC
load("data/sim.n2132.rda")
epi_stats(sim, ir.base, incid.base)


# High/moderate/low/non adherence, 50% RC
load("data/sim.n2138.rda")
epi_stats(sim, ir.base, incid.base)

# High/moderate/low/non adherence, 100% RC
load("data/sim.n2143.rda")
epi_stats(sim, ir.base, incid.base)


# Main partners only, 50% RC
load("data/sim.n2205.rda")
epi_stats(sim, ir.base, incid.base)

# Main partners only, 100% RC
load("data/sim.n2210.rda")
epi_stats(sim, ir.base, incid.base)


# Serodiscordant partners only, 50% RC
load("data/sim.n2305.rda")
epi_stats(sim, ir.base, incid.base)

# Serodiscordant partners only, 100% RC
load("data/sim.n2310.rda")
epi_stats(sim, ir.base, incid.base)



# Table 2 - Individual Level Outcomes -----------------------------------------------

# base scenario
d <- df$mtrans[df$rcomp == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p1[df$rcomp == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p0[df$rcomp == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$ptop[df$rcomp == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)) * 100, 1)


# 50% RC, High Adherence
d <- df$mtrans[df$rcomp == 0.5 & df$adr == 3]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p1[df$rcomp == 0.5 & df$adr == 3]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p0[df$rcomp == 0.5 & df$adr == 3]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$ptop[df$rcomp == 0.5 & df$adr == 3]
round(quantile(d, probs = c(0.5, 0.025, 0.975)) * 100, 1)


# 100% RC, High Adherence
d <- df$mtrans[df$rcomp == 1 & df$adr == 3]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p1[df$rcomp == 1 & df$adr == 3]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p0[df$rcomp == 1 & df$adr == 3]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$ptop[df$rcomp == 1 & df$adr == 3]
round(quantile(d, probs = c(0.5, 0.025, 0.975)) * 100, 1)


# 50% RC, High/Mod Adherence
d <- df$mtrans[df$rcomp == 0.5 & df$adr == 2]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p1[df$rcomp == 0.5 & df$adr == 2]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p0[df$rcomp == 0.5 & df$adr == 2]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$ptop[df$rcomp == 0.5 & df$adr == 2]
round(quantile(d, probs = c(0.5, 0.025, 0.975)) * 100, 1)


# 100% RC, High/Mod Adherence
d <- df$mtrans[df$rcomp == 1 & df$adr == 2]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p1[df$rcomp == 1 & df$adr == 2]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p0[df$rcomp == 1 & df$adr == 2]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$ptop[df$rcomp == 1 & df$adr == 2]
round(quantile(d, probs = c(0.5, 0.025, 0.975)) * 100, 1)


# 50% RC, High/Mod/Low Adherence
d <- df$mtrans[df$rcomp == 0.5 & df$adr == 1]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p1[df$rcomp == 0.5 & df$adr == 1]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p0[df$rcomp == 0.5 & df$adr == 1]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$ptop[df$rcomp == 0.5 & df$adr == 1]
round(quantile(d, probs = c(0.5, 0.025, 0.975)) * 100, 1)


# 100% RC, High/Mod/Low Adherence
d <- df$mtrans[df$rcomp == 1 & df$adr == 1]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p1[df$rcomp == 1 & df$adr == 1]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p0[df$rcomp == 1 & df$adr == 1]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$ptop[df$rcomp == 1 & df$adr == 1]
round(quantile(d, probs = c(0.5, 0.025, 0.975)) * 100, 1)


# 50% RC, High/Mod/Low/Non Adherence
d <- df$mtrans[df$rcomp == 0.5 & df$adr == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p1[df$rcomp == 0.5 & df$adr == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p0[df$rcomp == 0.5 & df$adr == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$ptop[df$rcomp == 0.5 & df$adr == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)) * 100, 1)


# 100% RC, High/Mod/Low/Non Adherence
d <- df$mtrans[df$rcomp == 1 & df$adr == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p1[df$rcomp == 1 & df$adr == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$mtrans.p0[df$rcomp == 1 & df$adr == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)), 2)

d <- df$ptop[df$rcomp == 1 & df$adr == 0]
round(quantile(d, probs = c(0.5, 0.025, 0.975)) * 100, 1)



# Main partners only, 50% RC
load("data/sim.n2205.rda")
sim <- truncate_sim(sim, at = 2600)$epi
mtrans <- unname(colMeans(sim$mean.trans, na.rm = TRUE)) * 1000
mtrans.p1 <- unname(colMeans(sim$mean.trans.prep, na.rm = TRUE)) * 1000
mtrans.p0 <- unname(colMeans(sim$mean.trans.nprep, na.rm = TRUE)) * 1000
ptop <- unname(colSums(sim$prepCurr)) / offst

round(quantile(mtrans, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(mtrans.p1, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(mtrans.p0, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(ptop, probs = c(0.5, 0.025, 0.975)) * 100, 1)

# Main partners only, 100% RC
load("data/sim.n2210.rda")
sim <- truncate_sim(sim, at = 2600)$epi
mtrans <- unname(colMeans(sim$mean.trans, na.rm = TRUE)) * 1000
mtrans.p1 <- unname(colMeans(sim$mean.trans.prep, na.rm = TRUE)) * 1000
mtrans.p0 <- unname(colMeans(sim$mean.trans.nprep, na.rm = TRUE)) * 1000
ptop <- unname(colSums(sim$prepCurr)) / offst

round(quantile(mtrans, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(mtrans.p1, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(mtrans.p0, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(ptop, probs = c(0.5, 0.025, 0.975)) * 100, 1)


# Serodiscordant partners only, 50% RC
load("data/sim.n2305.rda")
sim <- truncate_sim(sim, at = 2600)$epi
mtrans <- unname(colMeans(sim$mean.trans, na.rm = TRUE)) * 1000
mtrans.p1 <- unname(colMeans(sim$mean.trans.prep, na.rm = TRUE)) * 1000
mtrans.p0 <- unname(colMeans(sim$mean.trans.nprep, na.rm = TRUE)) * 1000
ptop <- unname(colSums(sim$prepCurr)) / offst

round(quantile(mtrans, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(mtrans.p1, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(mtrans.p0, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(ptop, probs = c(0.5, 0.025, 0.975)) * 100, 1)

# Serodiscordant partners only, 100% RC
load("data/sim.n2310.rda")
sim <- truncate_sim(sim, at = 2600)$epi
mtrans <- unname(colMeans(sim$mean.trans, na.rm = TRUE)) * 1000
mtrans.p1 <- unname(colMeans(sim$mean.trans.prep, na.rm = TRUE)) * 1000
mtrans.p0 <- unname(colMeans(sim$mean.trans.nprep, na.rm = TRUE)) * 1000
ptop <- unname(colSums(sim$prepCurr)) / offst

round(quantile(mtrans, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(mtrans.p1, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(mtrans.p0, probs = c(0.5, 0.025, 0.975)), 2)
round(quantile(ptop, probs = c(0.5, 0.025, 0.975)) * 100, 1)


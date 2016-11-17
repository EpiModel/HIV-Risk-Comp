
## New analysis for HIVR4P Poster

pdf(file = "../Figure1.PIAonly.pdf", height = 6, width = 6)
par(mfrow = c(1,1), mar = c(3,3,1,1), mgp = c(2,1,0))

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
     main = "", col = 1, bty = "n",
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

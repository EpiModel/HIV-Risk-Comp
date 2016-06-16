
## Test Script for stiPrEP Project

library(EpiModelHIVmsm)
sourceDir("source/", TRUE)

load("est/nwstats.10k.rda")

param <- param.msm(nwstats = st,
                   testing.pattern = "interval",
                   ai.scale = 1.323,
                   riskh.start = 1,
                   prep.start = 30,
                   prep.elig.model = "cdc3",
                   prep.class.prob = reallocate_pcp(reall = 0),
                   prep.class.hr = c(1, 0.69, 0.19, 0.05),
                   prep.coverage = 0.4,
                   prep.cov.method = "curr",
                   prep.cov.rate = 1,
                   prep.tst.int = 90,
                   prep.risk.int = 182,
                   rcomp.prob = 1,
                   rcomp.adh.groups = 0:4,
                   rcomp.main.only = FALSE,
                   rcomp.discl.only = FALSE)
init <- init.msm(nwstats = st, prev.B = 0.253, prev.W = 0.253)
control <- control.msm(simno = 1,
                       nsteps = 100,
                       nsims = 1,
                       ncores = 1,
                       save.int = 5000,
                       verbose.int = 1,
                       save.other = c("attr", "temp", "riskh", "el", "p"),
                       acts.FUN = acts.sti,
                       condoms.FUN = condoms.sti,
                       initialize.FUN = initialize.sti,
                       prep.FUN = prep.sti,
                       prev.FUN = prevalence.sti,
                       riskhist.FUN = riskhist.sti,
                       trans.FUN = trans.sti,
                       test.FUN = test.sti)

load("est/fit.10k.rda")
sim <- netsim(est, param, init, control)




# follow-up only ----------------------------------------------------------

load("est/nwstats.10k.rda")
sourceDir("source/", TRUE)
ai.scale <- 1.323
prev <- 0.253

param <- param.msm(nwstats = st,
                   testing.pattern = "interval",
                   ai.scale = ai.scale,
                   riskh.start = 2450,
                   prep.start = 2601,
                   prep.elig.model = "cdc3",
                   prep.class.prob = reallocate_pcp(reall = 0),
                   prep.class.hr = c(1, 0.69, 0.19, 0.05),
                   prep.coverage = 0.4,
                   prep.cov.method = "curr",
                   prep.cov.rate = 1,
                   prep.tst.int = 90,
                   prep.risk.int = 182,
                   rcomp.prob = 0,
                   rcomp.hadhr.only = TRUE,
                   rcomp.main.only = FALSE,
                   rcomp.discl.only = FALSE)
init <- init.msm(st)
control <- control.msm(simno = 1,
                       start = 2601,
                       nsteps = (52 * 50) + 100,
                       nsims = 1,
                       ncores = 1,
                       save.int = 5000,
                       verbose.int = 1,
                       save.other = NULL,
                       acts.FUN = acts.sti,
                       condoms.FUN = condoms.sti,
                       initialize.FUN = reinit.msm,
                       prep.FUN = prep.sti,
                       prev.FUN = prevalence.sti,
                       riskhist.FUN = riskhist.msm,
                       trans.FUN = trans.sti,
                       test.FUN = test.sti)

## Simulation
load("est/p2.burnin.rda")
# sim <- netsim(sim, param, init, control)

dat <- reinit.msm(sim, param, init, control, s = 1)
for (at in 2601:2750) {
  dat <- aging.msm(dat, at)
  dat <- deaths.msm(dat, at)
  dat <- births.msm(dat, at)
  dat <- test.sti(dat, at)
  dat <- tx.msm(dat, at)
  dat <- prep.sti(dat, at)
  dat <- progress.msm(dat, at)
  dat <- update_vl.msm(dat, at)
  dat <- edges_correct.msm(dat, at)
  dat <- simnet.msm(dat, at)
  dat <- disclose.msm(dat, at)
  dat <- acts.sti(dat, at)
  dat <- condoms.sti(dat, at)
  dat <- riskhist.msm(dat, at)
  dat <- position.msm(dat, at)
  dat <- trans.sti(dat, at)
  dat <- prevalence.sti(dat, at)
  cat("*")
}


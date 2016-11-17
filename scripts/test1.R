
## Test Script for stiPrEP Project

library("EpiModelHIV")
devtools::load_all("../../../Dev/EpiModelHIV/EpiModelHIV")

load("est/nwstats.10k.rda")

param <- param_msm(nwstats = st,
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
init <- init_msm(nwstats = st, prev.B = 0.253, prev.W = 0.253)
control <- control_msm(simno = 1,
                       nsteps = 100,
                       nsims = 1,
                       ncores = 1,
                       save.int = 5000,
                       verbose.int = 1,
                       save.other = c("attr", "temp", "riskh", "el", "p"))

load("est/fit.10k.rda")
sim <- netsim(est, param, init, control)




# follow-up only ----------------------------------------------------------

load("est/nwstats.10k.rda")
ai.scale <- 1.323

param <- param_msm(nwstats = st,
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
                   rcomp.adh.groups = 0:3,
                   rcomp.main.only = FALSE,
                   rcomp.discl.only = FALSE)
init <- init_msm(st)
control <- control_msm(simno = 1,
                       start = 2601,
                       nsteps = (52 * 50) + 100,
                       nsims = 1,
                       ncores = 1,
                       save.int = 5000,
                       verbose.int = 1,
                       save.other = NULL,
                       initialize.FUN = reinit_msm)

## Simulation
load("est/p2.burnin.rda")
sim2 <- netsim(sim, param, init, control)

dat <- reinit_msm(sim, param, init, control, s = 1)
for (at in 2601:2750) {
  dat <- aging_msm(dat, at)
  dat <- deaths_msm(dat, at)
  dat <- births_msm(dat, at)
  dat <- test_msm(dat, at)
  dat <- tx_msm(dat, at)
  dat <- prep_msm(dat, at)
  dat <- progress_msm(dat, at)
  dat <- vl_msm(dat, at)
  dat <- simnet_msm(dat, at)
  dat <- disclose_msm(dat, at)
  dat <- acts_msm(dat, at)
  dat <- condoms_msm(dat, at)
  dat <- riskhist_msm(dat, at)
  dat <- position_msm(dat, at)
  dat <- trans_msm(dat, at)
  dat <- prevalence_msm(dat, at)
  cat("*")
}


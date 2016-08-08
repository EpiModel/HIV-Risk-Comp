
## Packages
library("methods")
suppressMessages(library("EpiModelHIV"))
sourceDir("source/", FALSE)

## Environmental Arguments
args <- commandArgs(trailingOnly = TRUE)
simno <- args[1]
jobno <- args[2]

## Parameters
fsimno <- paste(simno, jobno, sep = ".")
load("est/nwstats.10k.rda")

# Base model
param <- param_msm(nwstats = st,
                   testing.pattern = "interval",
                   ai.scale = 1.323,
                   riskh.start = 2450,
                   prep.start = 2601,
                   prep.elig.model = "cdc3",
                   prep.class.prob = c(0.211, 0.07, 0.1, 0.619),
                   prep.class.hr = c(1, 0.69, 0.19, 0.05),
                   prep.coverage = 0.5,
                   prep.cov.method = "curr",
                   prep.cov.rate = 1,
                   prep.tst.int = 90,
                   prep.risk.int = 182,
                   rcomp.prob = 1,
                   rcomp.adh.groups = 0:4,
                   rcomp.main.only = FALSE,
                   rcomp.discl.only = FALSE)
init <- init_msm(nwstats = st, prev.B = 0.253, prev.W = 0.253)
control <- control_msm(simno = fsimno,
                       nsteps = 52 * 50,
                       nsims = 16,
                       ncores = 16,
                       save.int = 5000,
                       verbose.int = 100,
                       save.other = c("attr", "temp", "riskh", "el", "p"),
                       acts.FUN = acts.rc,
                       condoms.FUN = condoms.rc,
                       initialize.FUN = initialize.rc,
                       prep.FUN = prep.rc,
                       prev.FUN = prevalence.rc,
                       riskhist.FUN = riskhist.rc,
                       trans.FUN = trans.rc,
                       test.FUN = test.rc)

## Simulation
# netsim_hpc("est/fit.10k.rda", param, init, control, compress = "xz",
#             save.min = TRUE, save.max = TRUE)
netsim_hpc("est/fit.10k.rda", param, init, control, compress = "xz",
           save.min = TRUE, save.max = FALSE)
process_simfiles(min.n = 16)

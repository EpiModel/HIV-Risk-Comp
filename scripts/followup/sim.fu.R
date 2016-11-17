
## Packages
library("methods")
suppressMessages(library("EpiModelHIV"))
library("EpiModelHPC")

## Environmental Arguments
args <- commandArgs(trailingOnly = TRUE)
simno <- args[1]
jobno <- args[2]
cov <- as.numeric(args[3])
adr <- as.numeric(args[4])
rc1 <- as.numeric(args[5])
rc2 <- eval(parse(text = args[6]))
rc3 <- as.logical(args[7])
rc4 <- as.logical(args[8])
rc5 <- as.logical(args[9])

# ## Parameters
fsimno <- paste(simno, jobno, sep = ".")
load("est/nwstats.10k.rda")

param <- param_msm(nwstats = st,
                   testing.pattern = "interval",
                   ai.scale = 1.323,
                   riskh.start = 2450,
                   prep.start = 2601,
                   prep.elig.model = "cdc3",
                   prep.class.prob = reallocate_pcp(reall = adr - 0.019),
                   prep.class.hr = c(1, 0.69, 0.19, 0.05),
                   prep.coverage = cov,
                   prep.cov.method = "curr",
                   prep.cov.rate = 1,
                   prep.tst.int = 90,
                   prep.risk.int = 182,
                   rcomp.prob = rc1,
                   rcomp.adh.groups = rc2,
                   rcomp.main.only = rc3,
                   rcomp.discl.only = rc4,
                   rcomp.nmain.only = rc5)
init <- init_msm(st)
control <- control_msm(simno = fsimno,
                       start = 2601,
                       nsteps = (52 * 50) + 520,
                       nsims = 32,
                       ncores = 16,
                       save.other = NULL,
                       initialize.FUN = reinit_msm)

## Simulation
netsim_hpc("est/p2.burnin.rda", param, init, control, verbose = FALSE)

process_simfiles(simno = simno, min.n = 8, outdir = "data/")

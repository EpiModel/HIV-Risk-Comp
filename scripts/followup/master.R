
## build master.sh script ##

# base model
vars <- list(COV = 0,
             ADR = 0,
             RC1 = 0,
             RC2 = "0:4",
             RC3 = FALSE,
             RC4 = FALSE)
qsub_master(simno.start = 2000,
            nsubjobs = 8,
            backfill = FALSE,
            vars = vars,
            append = FALSE,
            runsimfile = "runsim.fu.sh",
            outfile = "scripts/followup/master.fu.sh")

# RC * high-adherent only interaction model
vars <- list(COV = 0.4,
             ADR = 0.019,
             RC1 = seq(0, 1, 0.1),
             RC2 = c("3", "2:3", "1:3", "0:3"),
             RC3 = FALSE,
             RC4 = FALSE)
qsub_master(simno.start = 2100,
            nsubjobs = 8,
            backfill = 5,
            vars = vars,
            append = TRUE,
            runsimfile = "runsim.fu.sh",
            outfile = "scripts/followup/master.fu.sh")

# RC when with main partners only
vars <- list(COV = 0.4,
             ADR = 0.019,
             RC1 = seq(0, 1, 0.1),
             RC2 = "0:4",
             RC3 = TRUE,
             RC4 = FALSE)
qsub_master(simno.start = 2200,
            nsubjobs = 8,
            backfill = TRUE,
            vars = vars,
            append = TRUE,
            runsimfile = "runsim.fu.sh",
            outfile = "scripts/followup/master.fu.sh")

# RC when with known serodiscordant only
vars <- list(COV = 0.4,
             ADR = 0.019,
             RC1 = seq(0, 1, 0.1),
             RC2 = "0:4",
             RC3 = FALSE,
             RC4 = TRUE)
qsub_master(simno.start = 2300,
            nsubjobs = 8,
            backfill = TRUE,
            vars = vars,
            append = TRUE,
            runsimfile = "runsim.fu.sh",
            outfile = "scripts/followup/master.fu.sh")

# RC when with casual partners only
vars <- list(COV = 0.4,
             ADR = 0.019,
             RC1 = seq(0, 1, 0.1),
             RC2 = "0:3",
             RC3 = FALSE,
             RC4 = FALSE,
             RC5 = TRUE)
qsub_master(simno.start = 2400,
            nsubjobs = 8,
            backfill = FALSE,
            vars = vars,
            append = TRUE,
            runsimfile = "runsim.fu.sh",
            outfile = "scripts/followup/master.fu.sh")

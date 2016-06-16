#!/bin/bash

## Burnin model
# qsub -q batch -t 1-7 -m n -v SIMNO=1000 runsim.burn.sh
qsub -q batch -t 1-16 -m n -v SIMNO=9000 runsim.burn.sh

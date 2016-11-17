
## Install stack to run scripts

devtools::install_github("statnet/EpiModel")
devtools::install_github("statnet/tergmLite", subdir = "tergmLite", ref = "preFastEl")
devtools::install_github("statnet/EpiModelHIV", ref = "hiv-risk-comp")

system("scp scripts/followup/*.fu.* hyak:/gscratch/csde/sjenness/riskcomp")

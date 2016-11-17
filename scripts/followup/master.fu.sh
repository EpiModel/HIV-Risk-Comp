#!/bin/bash

# qsub -q batch -t 1-8 -m n -v SIMNO=2000,COV=0,ADR=0,RC1=0,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
#
# qsub -q batch -t 1-8 -m n -v SIMNO=2100,COV=0.4,ADR=0.019,RC1=0,RC2=3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q batch -t 1-8 -m n -v SIMNO=2101,COV=0.4,ADR=0.019,RC1=0.1,RC2=3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q batch -t 1-8 -m n -v SIMNO=2102,COV=0.4,ADR=0.019,RC1=0.2,RC2=3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q batch -t 1-8 -m n -v SIMNO=2103,COV=0.4,ADR=0.019,RC1=0.3,RC2=3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q batch -t 1-8 -m n -v SIMNO=2104,COV=0.4,ADR=0.019,RC1=0.4,RC2=3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2105,COV=0.4,ADR=0.019,RC1=0.5,RC2=3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2106,COV=0.4,ADR=0.019,RC1=0.6,RC2=3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2107,COV=0.4,ADR=0.019,RC1=0.7,RC2=3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2108,COV=0.4,ADR=0.019,RC1=0.8,RC2=3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2109,COV=0.4,ADR=0.019,RC1=0.9,RC2=3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2110,COV=0.4,ADR=0.019,RC1=1,RC2=3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2111,COV=0.4,ADR=0.019,RC1=0,RC2=2:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2112,COV=0.4,ADR=0.019,RC1=0.1,RC2=2:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2113,COV=0.4,ADR=0.019,RC1=0.2,RC2=2:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2114,COV=0.4,ADR=0.019,RC1=0.3,RC2=2:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2115,COV=0.4,ADR=0.019,RC1=0.4,RC2=2:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2116,COV=0.4,ADR=0.019,RC1=0.5,RC2=2:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2117,COV=0.4,ADR=0.019,RC1=0.6,RC2=2:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2118,COV=0.4,ADR=0.019,RC1=0.7,RC2=2:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2119,COV=0.4,ADR=0.019,RC1=0.8,RC2=2:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2120,COV=0.4,ADR=0.019,RC1=0.9,RC2=2:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2121,COV=0.4,ADR=0.019,RC1=1,RC2=2:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2122,COV=0.4,ADR=0.019,RC1=0,RC2=1:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2123,COV=0.4,ADR=0.019,RC1=0.1,RC2=1:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2124,COV=0.4,ADR=0.019,RC1=0.2,RC2=1:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2125,COV=0.4,ADR=0.019,RC1=0.3,RC2=1:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2126,COV=0.4,ADR=0.019,RC1=0.4,RC2=1:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2127,COV=0.4,ADR=0.019,RC1=0.5,RC2=1:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2128,COV=0.4,ADR=0.019,RC1=0.6,RC2=1:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2129,COV=0.4,ADR=0.019,RC1=0.7,RC2=1:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2130,COV=0.4,ADR=0.019,RC1=0.8,RC2=1:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2131,COV=0.4,ADR=0.019,RC1=0.9,RC2=1:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2132,COV=0.4,ADR=0.019,RC1=1,RC2=1:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2133,COV=0.4,ADR=0.019,RC1=0,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2134,COV=0.4,ADR=0.019,RC1=0.1,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2135,COV=0.4,ADR=0.019,RC1=0.2,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2136,COV=0.4,ADR=0.019,RC1=0.3,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2137,COV=0.4,ADR=0.019,RC1=0.4,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2138,COV=0.4,ADR=0.019,RC1=0.5,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2139,COV=0.4,ADR=0.019,RC1=0.6,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2140,COV=0.4,ADR=0.019,RC1=0.7,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2141,COV=0.4,ADR=0.019,RC1=0.8,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2142,COV=0.4,ADR=0.019,RC1=0.9,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2143,COV=0.4,ADR=0.019,RC1=1,RC2=0:3,RC3=FALSE,RC4=FALSE runsim.fu.sh
#
# qsub -q bf -t 1-8 -m n -v SIMNO=2200,COV=0.4,ADR=0.019,RC1=0,RC2=0:4,RC3=TRUE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2201,COV=0.4,ADR=0.019,RC1=0.1,RC2=0:4,RC3=TRUE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2202,COV=0.4,ADR=0.019,RC1=0.2,RC2=0:4,RC3=TRUE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2203,COV=0.4,ADR=0.019,RC1=0.3,RC2=0:4,RC3=TRUE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2204,COV=0.4,ADR=0.019,RC1=0.4,RC2=0:4,RC3=TRUE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2205,COV=0.4,ADR=0.019,RC1=0.5,RC2=0:4,RC3=TRUE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2206,COV=0.4,ADR=0.019,RC1=0.6,RC2=0:4,RC3=TRUE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2207,COV=0.4,ADR=0.019,RC1=0.7,RC2=0:4,RC3=TRUE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2208,COV=0.4,ADR=0.019,RC1=0.8,RC2=0:4,RC3=TRUE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2209,COV=0.4,ADR=0.019,RC1=0.9,RC2=0:4,RC3=TRUE,RC4=FALSE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2210,COV=0.4,ADR=0.019,RC1=1,RC2=0:4,RC3=TRUE,RC4=FALSE runsim.fu.sh
#
# qsub -q bf -t 1-8 -m n -v SIMNO=2300,COV=0.4,ADR=0.019,RC1=0,RC2=0:4,RC3=FALSE,RC4=TRUE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2301,COV=0.4,ADR=0.019,RC1=0.1,RC2=0:4,RC3=FALSE,RC4=TRUE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2302,COV=0.4,ADR=0.019,RC1=0.2,RC2=0:4,RC3=FALSE,RC4=TRUE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2303,COV=0.4,ADR=0.019,RC1=0.3,RC2=0:4,RC3=FALSE,RC4=TRUE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2304,COV=0.4,ADR=0.019,RC1=0.4,RC2=0:4,RC3=FALSE,RC4=TRUE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2305,COV=0.4,ADR=0.019,RC1=0.5,RC2=0:4,RC3=FALSE,RC4=TRUE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2306,COV=0.4,ADR=0.019,RC1=0.6,RC2=0:4,RC3=FALSE,RC4=TRUE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2307,COV=0.4,ADR=0.019,RC1=0.7,RC2=0:4,RC3=FALSE,RC4=TRUE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2308,COV=0.4,ADR=0.019,RC1=0.8,RC2=0:4,RC3=FALSE,RC4=TRUE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2309,COV=0.4,ADR=0.019,RC1=0.9,RC2=0:4,RC3=FALSE,RC4=TRUE runsim.fu.sh
# qsub -q bf -t 1-8 -m n -v SIMNO=2310,COV=0.4,ADR=0.019,RC1=1,RC2=0:4,RC3=FALSE,RC4=TRUE runsim.fu.sh

qsub -q batch -t 1-8 -m n -v SIMNO=2400,COV=0.4,ADR=0.019,RC1=0,RC2=0:3,RC3=FALSE,RC4=FALSE,RC5=TRUE runsim.fu.sh
qsub -q batch -t 1-8 -m n -v SIMNO=2401,COV=0.4,ADR=0.019,RC1=0.1,RC2=0:3,RC3=FALSE,RC4=FALSE,RC5=TRUE runsim.fu.sh
qsub -q batch -t 1-8 -m n -v SIMNO=2402,COV=0.4,ADR=0.019,RC1=0.2,RC2=0:3,RC3=FALSE,RC4=FALSE,RC5=TRUE runsim.fu.sh
qsub -q batch -t 1-8 -m n -v SIMNO=2403,COV=0.4,ADR=0.019,RC1=0.3,RC2=0:3,RC3=FALSE,RC4=FALSE,RC5=TRUE runsim.fu.sh
qsub -q batch -t 1-8 -m n -v SIMNO=2404,COV=0.4,ADR=0.019,RC1=0.4,RC2=0:3,RC3=FALSE,RC4=FALSE,RC5=TRUE runsim.fu.sh
qsub -q batch -t 1-8 -m n -v SIMNO=2405,COV=0.4,ADR=0.019,RC1=0.5,RC2=0:3,RC3=FALSE,RC4=FALSE,RC5=TRUE runsim.fu.sh
qsub -q batch -t 1-8 -m n -v SIMNO=2406,COV=0.4,ADR=0.019,RC1=0.6,RC2=0:3,RC3=FALSE,RC4=FALSE,RC5=TRUE runsim.fu.sh
qsub -q batch -t 1-8 -m n -v SIMNO=2407,COV=0.4,ADR=0.019,RC1=0.7,RC2=0:3,RC3=FALSE,RC4=FALSE,RC5=TRUE runsim.fu.sh
qsub -q batch -t 1-8 -m n -v SIMNO=2408,COV=0.4,ADR=0.019,RC1=0.8,RC2=0:3,RC3=FALSE,RC4=FALSE,RC5=TRUE runsim.fu.sh
qsub -q batch -t 1-8 -m n -v SIMNO=2409,COV=0.4,ADR=0.019,RC1=0.9,RC2=0:3,RC3=FALSE,RC4=FALSE,RC5=TRUE runsim.fu.sh
qsub -q batch -t 1-8 -m n -v SIMNO=2410,COV=0.4,ADR=0.019,RC1=1,RC2=0:3,RC3=FALSE,RC4=FALSE,RC5=TRUE runsim.fu.sh

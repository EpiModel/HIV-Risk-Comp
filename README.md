## Risk Compensation after HIV Preexposure Prophylaxis among MSM

This repository holds the source to code to reproduce the analysis featured in our HIV transmission model among men who have sex with men, as described below. In that model, we investigated the extent and causal mechanisms through which condom-related risk compensation could potentially reduce the effectiveness of HIV preexposure prophylaxis (PrEP).

<img src="https://github.com/statnet/HIV-Risk-Comp/raw/master/analysis/Figure1.jpg">

These models are written and executed in the R statistical software language. To run these files, it is necessary to first install our epidemic modeling software, [EpiModel](http://epimodel.org/), and our extension package specifically for modeling HIV transmission dynamics among MSM, [EpiModelHIV](http://github.com/statnet/EpiModelHIV).

In R:
```
install.packages("EpiModel")

# install devtools if necessary, install.packages("devtools")
devtools::install_github("statnet/tergmLite", ref = "preFastEl")
devtools::install_github("statnet/EpiModelHIV", ref = "hiv-risk-comp")
```

<img src="https://github.com/statnet/HIV-Risk-Comp/raw/master/analysis/Figure2.jpg">


### Citation

> Jenness SM, Sharma A, Goodreau SM, Rosenberg ES, Weiss KM, Hoover KW, Smith DK, Sullivan P. Individual HIV Risk versus Population Impact of Risk Compensation after HIV Preexposure Prophylaxis Initiation among Men Who Have Sex with Men. _PLoS One._ 2017; 12(1): e0169484. [[LINK]](https://www.ncbi.nlm.nih.gov/pubmed/28060881)

<img src="https://github.com/statnet/HIV-Risk-Comp/raw/master/analysis/Figure3.jpg">


### Abstract

#### Objectives 	
Risk compensation (RC) could reduce or offset the biological prevention benefits of HIV preexposure prophylaxis (PrEP) among those at substantial risk of infection, including men who have sex with men (MSM). We investigated the potential extent and causal mechanisms through which RC could impact HIV transmission at the population and individual levels.

#### Methods 	
Using a stochastic network-based mathematical model of HIV transmission dynamics among MSM in the United States, we simulated RC as a reduction in the probability of condom use after initiating PrEP, with heterogeneity by PrEP adherence profiles and partnership type in which RC occurred. Outcomes were changes to population-level HIV incidence and individual-level acquisition risk.

#### Results 	
When RC was limited to MSM highly/moderately adherent to PrEP, 100% RC (full replacement of condoms) resulted in a 2% relative decline in incidence compared to no RC, but an 8% relative increase in infection risk for MSM on PrEP. This resulted from confounding by indication: RC increased the number of MSM indicated for PrEP as a function of more condomless anal intercourse among men otherwise not indicated for PrEP; this led to an increased PrEP uptake and subsequent decline in incidence.

#### Conclusions 	
RC is unlikely to decrease the prevention impact of PrEP, and in some cases RC may be counterintuitively beneficial at the population level. This depended on PrEP uptake scaling with behavioral indications. Due to the increased acquisition risk associated with RC, however, clinicians should continue to support PrEP as a supplement rather than replacement of condoms.

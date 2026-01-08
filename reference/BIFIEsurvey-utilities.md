# Utility Functions in BIFIEsurvey

Utility functions in BIFIEsurvey.

## Usage

``` r
## Rubin rules for combining multiple imputation estimates
bifiesurvey_rcpp_rubin_rules(estimates, variances)

## computation of replication variance
bifiesurvey_rcpp_replication_variance(pars, pars_repl, fay_factor)

## statistical inference for nested multiple imputation
BIFIE_NMI_inference_parameters( parsM, parsrepM, fayfac, RR, Nimp, Nimp_NMI,
      comp_cov=FALSE)
```

## Arguments

- estimates:

  Vector

- variances:

  Vector

- pars:

  Matrix

- pars_repl:

  Matrix

- fay_factor:

  Vector

- parsM:

  Matrix

- parsrepM:

  Matrix

- fayfac:

  Vector

- RR:

  Numeric

- Nimp:

  Integer

- Nimp_NMI:

  Integer

- comp_cov:

  Logical

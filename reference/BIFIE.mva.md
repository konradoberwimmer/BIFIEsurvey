# Missing Value Analysis

Conducts a missing value analysis.

## Usage

``` r
BIFIE.mva( BIFIEobj, missvars, covariates=NULL, se=TRUE )

# S3 method for class 'BIFIE.mva'
summary(object,digits=4,...)
```

## Arguments

- BIFIEobj:

  Object of class `BIFIEdata`

- missvars:

  Vector of variables for which missing value statistics should be
  computed

- covariates:

  Vector of variables which work as covariates

- se:

  Optional logical indicating whether statistical inference based on
  replication should be employed.

- object:

  Object of class `BIFIE.correl`

- digits:

  Number of digits for rounding output

- ...:

  Further arguments to be passed

## Value

A list with following entries

- stat.mva:

  Data frame with missing value statistics

- res_list:

  List with extensive output split according to each variable in
  `missvars`

- ...:

  More values

## Examples

``` r
#############################################################################
# EXAMPLE 1: Imputed TIMSS dataset
#############################################################################

data(data.timss1)
data(data.timssrep)

# create BIFIE.dat object
BIFIEdata <- BIFIEsurvey::BIFIE.data( data.list=data.timss1,
                wgt=data.timss1[[1]]$TOTWGT, wgtrep=data.timssrep[, -1 ] )
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|

# missing value analysis for "scsci" and "books" and three covariates
res1 <- BIFIEsurvey::BIFIE.mva( BIFIEdata, missvars=c("scsci", "books" ),
             covariates=c("ASMMAT", "female", "ASSSCI") )
#> |*****|
#> |-----|
#> |-----|
#> |*****|
#> |-----|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.mva'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.mva(BIFIEobj = BIFIEdata, missvars = c("scsci", 
#>     "books"), covariates = c("ASMMAT", "female", "ASSSCI"))
#> 
#> Date of Analysis: 2026-01-09 04:20:13.509382 
#> Time difference of 0.1264596 secs
#> Computation time: 0.1264596 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Missing Value Analysis 
#>      respvar missprop covariate       d   d_SE   M_resp   M_miss SD_resp
#> 1 resp_scsci   0.0264    ASMMAT -0.2453 0.1262 508.7303 492.8726 62.5307
#> 2 resp_scsci   0.0264    female -0.0191 0.1043   0.4880   0.4784  0.4999
#> 3 resp_scsci   0.0264    ASSSCI -0.2828 0.1211 532.0598 510.9723 70.1550
#> 4 resp_books   0.0221    ASMMAT -0.5583 0.1182 509.0749 474.4610 62.5112
#> 5 resp_books   0.0221    female -0.2755 0.1090   0.4907   0.3558  0.4999
#> 6 resp_books   0.0221    ASSSCI -0.5538 0.1399 532.3883 492.2369 70.1175
#>   SD_miss
#> 1 66.6633
#> 2  0.4996
#> 3 78.7391
#> 4 61.4851
#> 5  0.4789
#> 6 74.8985

# missing value analysis without statistical inference and without covariates
res2 <- BIFIEsurvey::BIFIE.mva( BIFIEdata, missvars=c("scsci", "books"), se=FALSE)
#> |*****|
#> |-----|
#> |-----|
#> |*****|
#> |-----|
#> |-----|
summary(res2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.mva'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.mva(BIFIEobj = BIFIEdata, missvars = c("scsci", 
#>     "books"), se = FALSE)
#> 
#> Date of Analysis: 2026-01-09 04:20:13.639684 
#> Time difference of 0.01079106 secs
#> Computation time: 0.01079106 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 2 
#> Fay factor = 1 
#> 
#> Missing Value Analysis 
#>      respvar missprop
#> 1 resp_scsci   0.0264
#> 2 resp_books   0.0221
```

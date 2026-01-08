# Univariate Descriptive Statistics (Means and Standard Deviations)

Computes some univariate descriptive statistics (means and standard
deviations).

## Usage

``` r
BIFIE.univar(BIFIEobj, vars, group=NULL, group_values=NULL, se=TRUE)

# S3 method for class 'BIFIE.univar'
summary(object,digits=3,...)

# S3 method for class 'BIFIE.univar'
coef(object,...)

# S3 method for class 'BIFIE.univar'
vcov(object,...)
```

## Arguments

- BIFIEobj:

  Object of class `BIFIEdata`

- vars:

  Vector of variables for which statistics should be computed

- group:

  Optional grouping variable(s)

- group_values:

  Optional vector of grouping values. This can be omitted and grouping
  values will be determined automatically.

- se:

  Optional logical indicating whether statistical inference based on
  replication should be employed.

- object:

  Object of class `BIFIE.univar`

- digits:

  Number of digits for rounding output

- ...:

  Further arguments to be passed

## Value

A list with following entries

- stat:

  Data frame with univariate statistics

- stat_M:

  Data frame with means

- stat_SD:

  Data frame with standard deviations

- output:

  Extensive output with all replicated statistics

- ...:

  More values

## See also

See
[`BIFIE.univar.test`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.univar.test.md)
for a test of equal means and effect sizes \\\eta\\ and \\d\\.

Descriptive statistics without statistical inference can be estimated by
the collection of
[`miceadds::ma.wtd.statNA`](https://rdrr.io/pkg/miceadds/man/ma.wtd.statNA.html)
functions from the miceadds package.

Further descriptive functions:

[`survey::svymean`](https://rdrr.io/pkg/survey/man/surveysummary.html),
[`intsvy::timss.mean`](https://rdrr.io/pkg/intsvy/man/timss.mean.html),
[`intsvy::timss.mean.pv`](https://rdrr.io/pkg/intsvy/man/timss.mean.pv.html),
[`stats::weighted.mean`](https://rdrr.io/r/stats/weighted.mean.html),
[`Hmisc::wtd.mean`](https://rdrr.io/pkg/Hmisc/man/wtd.stats.html),
[`miceadds::ma.wtd.meanNA`](https://rdrr.io/pkg/miceadds/man/ma.wtd.statNA.html)

[`survey::svyvar`](https://rdrr.io/pkg/survey/man/surveysummary.html),
[`Hmisc::wtd.var`](https://rdrr.io/pkg/Hmisc/man/wtd.stats.html),
[`miceadds::ma.wtd.sdNA`](https://rdrr.io/pkg/miceadds/man/ma.wtd.statNA.html),
[`miceadds::ma.wtd.covNA`](https://rdrr.io/pkg/miceadds/man/ma.wtd.statNA.html)

## Examples

``` r
#############################################################################
# EXAMPLE 1: Imputed TIMSS dataset
#############################################################################

data(data.timss1)
data(data.timssrep)

# create BIFIE.dat object
bdat <- BIFIEsurvey::BIFIE.data( data.list=data.timss1, wgt=data.timss1[[1]]$TOTWGT,
           wgtrep=data.timssrep[, -1 ] )
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|

# compute descriptives for plausible values
res1 <- BIFIEsurvey::BIFIE.univar( bdat, vars=c("ASMMAT","ASSSCI","books") )
#> |*****|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat, vars = c("ASMMAT", 
#>     "ASSSCI", "books"))
#> 
#> Date of Analysis: 2026-01-08 12:35:56.05197 
#> Time difference of 0.05942845 secs
#> Computation time: 0.05942845 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Univariate Statistics | Means
#>      var  Nweight Ncases       M  M_SE   M_df     M_t M_p M_fmi M_VarMI
#> 1 ASMMAT 78332.99   4668 508.311 2.617    Inf 194.268   0 0.050   0.284
#> 2 ASSSCI 78332.99   4668 531.502 2.886 369.42 184.185   0 0.104   0.722
#> 3  books 78332.99   4668   2.937 0.040    Inf  73.270   0 0.005   0.000
#>   M_VarRep
#> 1    6.505
#> 2    7.461
#> 3    0.002
#> 
#> Univariate Statistics | Standard Deviations
#>      var  Nweight Ncases     SD SD_SE SD_df    SD_t SD_p
#> 1 ASMMAT 78332.99   4668 62.696 1.088 57.07 467.401    0
#> 2 ASSSCI 78332.99   4668 70.477 1.344 28.07 395.539    0
#> 3  books 78332.99   4668  1.147 0.015   Inf 195.485    0

# split descriptives by number of books
res2 <- BIFIEsurvey::BIFIE.univar( bdat, vars=c("ASMMAT","ASSSCI"), group="books",
            group_values=1:5)
#> |*****|
#> |-----|
summary(res2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat, vars = c("ASMMAT", 
#>     "ASSSCI"), group = "books", group_values = 1:5)
#> 
#> Date of Analysis: 2026-01-08 12:35:56.117144 
#> Time difference of 0.04500723 secs
#> Computation time: 0.04500723 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Univariate Statistics | Means
#>       var groupvar groupval   Nweight Ncases       M  M_SE   M_df     M_t M_p
#> 1  ASMMAT    books        1  7889.467  484.0 462.463 4.704  67.69  98.307   0
#> 2  ASMMAT    books        2 20602.693 1213.2 488.408 3.455 798.28 141.366   0
#> 3  ASMMAT    books        3 28233.896 1657.6 516.889 2.408 123.28 214.692   0
#> 4  ASMMAT    books        4 11754.811  708.8 532.942 3.158 125.24 168.760   0
#> 5  ASMMAT    books        5  9852.122  604.4 532.664 3.210 304.41 165.944   0
#> 6  ASSSCI    books        1  7889.467  484.0 474.183 5.900  38.76  80.374   0
#> 7  ASSSCI    books        2 20602.693 1213.2 507.314 4.099 102.59 123.778   0
#> 8  ASSSCI    books        3 28233.896 1657.6 542.211 2.591  54.59 209.306   0
#> 9  ASSSCI    books        4 11754.811  708.8 559.753 3.273  87.11 171.008   0
#> 10 ASSSCI    books        5  9852.122  604.4 563.601 3.495 103.83 161.264   0
#>    M_fmi M_VarMI M_VarRep
#> 1  0.243   4.483   16.750
#> 2  0.071   0.704   11.092
#> 3  0.180   0.870    4.752
#> 4  0.179   1.485    8.191
#> 5  0.115   0.984    9.122
#> 6  0.321   9.318   23.625
#> 7  0.197   2.764   13.481
#> 8  0.271   1.514    4.894
#> 9  0.214   1.913    8.418
#> 10 0.196   1.998    9.817
#> 
#> Univariate Statistics | Standard Deviations
#>       var groupvar groupval   Nweight Ncases     SD SD_SE  SD_df    SD_t SD_p
#> 1  ASMMAT    books        1  7889.467  484.0 59.667 3.350  60.78 138.043    0
#> 2  ASMMAT    books        2 20602.693 1213.2 59.146 1.774 163.20 275.269    0
#> 3  ASMMAT    books        3 28233.896 1657.6 57.654 1.335  95.77 387.101    0
#> 4  ASMMAT    books        4 11754.811  708.8 57.709 1.863 640.19 286.114    0
#> 5  ASMMAT    books        5  9852.122  604.4 59.502 2.537  37.73 209.995    0
#> 6  ASSSCI    books        1  7889.467  484.0 71.334 3.286 642.31 144.321    0
#> 7  ASSSCI    books        2 20602.693 1213.2 66.532 1.806  91.17 280.916    0
#> 8  ASSSCI    books        3 28233.896 1657.6 62.825 1.643  22.53 329.936    0
#> 9  ASSSCI    books        4 11754.811  708.8 62.818 2.075 110.46 269.812    0
#> 10 ASSSCI    books        5  9852.122  604.4 62.951 2.759  64.39 204.256    0
#>    SD_fmi SD_VarMI SD_VarRep
#> 1   0.257    2.399     8.344
#> 2   0.157    0.411     2.655
#> 3   0.204    0.304     1.419
#> 4   0.079    0.229     3.195
#> 5   0.326    1.746     4.339
#> 6   0.079    0.710     9.943
#> 7   0.209    0.569     2.578
#> 8   0.421    0.948     1.563
#> 9   0.190    0.683     3.485
#> 10  0.249    1.581     5.716

#############################################################################
# EXAMPLE 2: TIMSS dataset with missings
#############################################################################

data(data.timss2)
data(data.timssrep)

# use first dataset with missing data from data.timss2
bdat1 <- BIFIEsurvey::BIFIE.data( data.list=data.timss2[[1]], wgt=data.timss2[[1]]$TOTWGT,
               wgtrep=data.timssrep[, -1 ])
#> +++ Generate BIFIE.data object
#> |*|
#> |-|

# some descriptive statistics without statistical inference
res1a <- BIFIEsurvey::BIFIE.univar( bdat1, vars=c("ASMMAT","ASSSCI","books"), se=FALSE)
#> |*|
#> |-|
# descriptive statistics with statistical inference
res1b <- BIFIEsurvey::BIFIE.univar( bdat1, vars=c("ASMMAT","ASSSCI","books") )
#> |*|
#> |-|
summary(res1a)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat1, vars = c("ASMMAT", 
#>     "ASSSCI", "books"), se = FALSE)
#> 
#> Date of Analysis: 2026-01-08 12:35:56.193188 
#> Time difference of 0.002236843 secs
#> Computation time: 0.002236843 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 1 
#> Number of Jackknife zones per dataset = 0 
#> Fay factor = 1 
#> 
#> Univariate Statistics | Means
#>      var  Nweight Ncases       M
#> 1 ASMMAT 78332.99   4668 508.590
#> 2 ASSSCI 78332.99   4668 532.906
#> 3  books 78332.99   4554   2.945
#> 
#> Univariate Statistics | Standard Deviations
#>      var  Nweight Ncases     SD
#> 1 ASMMAT 78332.99   4668 62.725
#> 2 ASSSCI 78332.99   4668 69.694
#> 3  books 78332.99   4554  1.146
summary(res1b)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat1, vars = c("ASMMAT", 
#>     "ASSSCI", "books"))
#> 
#> Date of Analysis: 2026-01-08 12:35:56.196072 
#> Time difference of 0.01373768 secs
#> Computation time: 0.01373768 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 1 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Univariate Statistics | Means
#>      var  Nweight Ncases       M  M_SE M_df     M_t M_p M_VarRep
#> 1 ASMMAT 78332.99   4668 508.590 2.575   NA 197.535  NA    6.629
#> 2 ASSSCI 78332.99   4668 532.906 2.691   NA 198.033  NA    7.241
#> 3  books 78332.99   4554   2.945 0.040   NA  73.110  NA    0.002
#> 
#> Univariate Statistics | Standard Deviations
#>      var  Nweight Ncases     SD SD_SE SD_df    SD_t SD_p
#> 1 ASMMAT 78332.99   4668 62.725 0.948    NA 536.334   NA
#> 2 ASSSCI 78332.99   4668 69.694 1.123    NA 474.625   NA
#> 3  books 78332.99   4554  1.146 0.015    NA 195.134   NA

# split descriptives by number of books
res2 <- BIFIEsurvey::BIFIE.univar( bdat1, vars=c("ASMMAT","ASSSCI"), group="books")
#> |*|
#> |-|
# Note that if group_values is not specified as an argument it will be
# automatically determined by the observed frequencies in the dataset
summary(res2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat1, vars = c("ASMMAT", 
#>     "ASSSCI"), group = "books")
#> 
#> Date of Analysis: 2026-01-08 12:35:56.217831 
#> Time difference of 0.01028562 secs
#> Computation time: 0.01028562 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 1 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Univariate Statistics | Means
#>       var groupvar groupval   Nweight Ncases       M  M_SE M_df     M_t M_p
#> 1  ASMMAT    books        1  7609.320    464 466.444 4.520   NA 103.201  NA
#> 2  ASMMAT    books        2 19993.365   1174 489.631 3.044   NA 160.834  NA
#> 3  ASMMAT    books        3 27691.856   1622 517.070 2.179   NA 237.342  NA
#> 4  ASMMAT    books        4 11591.981    699 533.460 2.888   NA 184.719  NA
#> 5  ASMMAT    books        5  9702.202    595 532.790 3.046   NA 174.932  NA
#> 6  ASSSCI    books        1  7609.320    464 476.618 4.848   NA  98.315  NA
#> 7  ASSSCI    books        2 19993.365   1174 510.318 3.676   NA 138.820  NA
#> 8  ASSSCI    books        3 27691.856   1622 544.548 2.143   NA 254.100  NA
#> 9  ASSSCI    books        4 11591.981    699 560.435 3.011   NA 186.104  NA
#> 10 ASSSCI    books        5  9702.202    595 563.692 3.336   NA 168.961  NA
#>    M_VarRep
#> 1    20.428
#> 2     9.268
#> 3     4.746
#> 4     8.340
#> 5     9.276
#> 6    23.502
#> 7    13.514
#> 8     4.593
#> 9     9.069
#> 10   11.130
#> 
#> Univariate Statistics | Standard Deviations
#>       var groupvar groupval   Nweight Ncases     SD SD_SE SD_df    SD_t SD_p
#> 1  ASMMAT    books        1  7609.320    464 61.668 2.897    NA 161.007   NA
#> 2  ASMMAT    books        2 19993.365   1174 59.064 1.338    NA 366.013   NA
#> 3  ASMMAT    books        3 27691.856   1622 57.346 1.201    NA 430.496   NA
#> 4  ASMMAT    books        4 11591.981    699 58.107 2.147    NA 248.451   NA
#> 5  ASMMAT    books        5  9702.202    595 60.051 1.891    NA 281.705   NA
#> 6  ASSSCI    books        1  7609.320    464 70.792 3.258    NA 146.313   NA
#> 7  ASSSCI    books        2 19993.365   1174 65.278 1.741    NA 293.111   NA
#> 8  ASSSCI    books        3 27691.856   1622 61.913 1.206    NA 451.425   NA
#> 9  ASSSCI    books        4 11591.981    699 61.476 1.879    NA 298.189   NA
#> 10 ASSSCI    books        5  9702.202    595 63.620 2.789    NA 202.078   NA
#>    SD_VarRep
#> 1      8.393
#> 2      1.790
#> 3      1.443
#> 4      4.610
#> 5      3.577
#> 6     10.611
#> 7      3.031
#> 8      1.455
#> 9      3.532
#> 10     7.781
```

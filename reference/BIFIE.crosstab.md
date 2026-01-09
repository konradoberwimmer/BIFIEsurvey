# Cross Tabulation

Creates cross tabulations and computes some effect sizes.

## Usage

``` r
BIFIE.crosstab( BIFIEobj, vars1, vars2, vars_values1=NULL, vars_values2=NULL,
     group=NULL, group_values=NULL, se=TRUE )

# S3 method for class 'BIFIE.crosstab'
summary(object,digits=3,...)

# S3 method for class 'BIFIE.crosstab'
coef(object,...)

# S3 method for class 'BIFIE.crosstab'
vcov(object,...)
```

## Arguments

- BIFIEobj:

  Object of class `BIFIEdata`

- vars1:

  Row variable

- vars2:

  Column variable

- vars_values1:

  Optional vector of values of variable `vars1`

- vars_values2:

  Optional vector of values of variable `vars2`

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

- stat.probs:

  Statistics for joint and conditional probabilities

- stat.marg:

  Statistics for marginal probabilities

- stat.es:

  Statistics for effect sizes \\w\\ (based on \\\chi^2\\), Cramers
  \\V\\, Goodman's gamma, the PRE lambda measure and Kruskals tau.

- output:

  Extensive output with all replicated statistics

- ...:

  More values

## See also

[`survey::svytable`](https://rdrr.io/pkg/survey/man/svychisq.html),
[`Hmisc::wtd.table`](https://rdrr.io/pkg/Hmisc/man/wtd.stats.html)

## Examples

``` r
#############################################################################
# EXAMPLE 1: Imputed TIMSS dataset
#############################################################################

data(data.timss1)
data(data.timssrep)

# create BIFIE.dat object
bifieobj <- BIFIEsurvey::BIFIE.data( data.list=data.timss1, wgt=data.timss1[[1]]$TOTWGT,
           wgtrep=data.timssrep[, -1 ] )
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|

#--- Model 1: cross tabulation
res1 <- BIFIEsurvey::BIFIE.crosstab( bifieobj, vars1="migrant",
               vars2="books", group="female" )
#> |*****|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.crosstab'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.crosstab(BIFIEobj = bifieobj, vars1 = "migrant", 
#>     vars2 = "books", group = "female")
#> 
#> Date of Analysis: 2026-01-09 04:20:06.079531 
#> Time difference of 0.248903 secs
#> Computation time: 0.248903 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Joint and Conditional Probabilities
#>       prob    var1 varval1  var2 varval2  group groupval Ncases   Nweight   est
#> 1    joint migrant       0 books       1 female        0  162.6  2929.601 0.073
#> 2    joint migrant       0 books       2 female        0  434.2  7965.610 0.198
#> 3    joint migrant       0 books       3 female        0  663.4 11627.561 0.290
#> 4    joint migrant       0 books       4 female        0  293.6  4876.792 0.122
#> 5    joint migrant       0 books       5 female        0  303.8  4918.441 0.123
#> 6    joint migrant       1 books       1 female        0  151.4  2328.836 0.058
#> 7    joint migrant       1 books       2 female        0  178.0  2683.693 0.067
#> 8    joint migrant       1 books       3 female        0  136.2  1916.525 0.048
#> 9    joint migrant       1 books       4 female        0   31.8   415.302 0.010
#> 10   joint migrant       1 books       5 female        0   33.6   467.407 0.012
#> 11   joint migrant       0 books       1 female        1   71.2  1270.661 0.033
#> 12   joint migrant       0 books       2 female        1  385.0  6870.760 0.180
#> 13   joint migrant       0 books       3 female        1  715.0 12483.328 0.327
#> 14   joint migrant       0 books       4 female        1  355.2  6051.650 0.158
#> 15   joint migrant       0 books       5 female        1  230.6  3805.948 0.100
#> 16   joint migrant       1 books       1 female        1   98.8  1360.369 0.036
#> 17   joint migrant       1 books       2 female        1  216.0  3082.630 0.081
#> 18   joint migrant       1 books       3 female        1  143.0  2206.482 0.058
#> 19   joint migrant       1 books       4 female        1   28.2   411.067 0.011
#> 20   joint migrant       1 books       5 female        1   36.4   660.327 0.017
#> 21 rowcond migrant       0 books       1 female        0  162.6  2929.601 0.091
#> 22 rowcond migrant       0 books       2 female        0  434.2  7965.610 0.246
#> 23 rowcond migrant       0 books       3 female        0  663.4 11627.561 0.360
#> 24 rowcond migrant       0 books       4 female        0  293.6  4876.792 0.151
#> 25 rowcond migrant       0 books       5 female        0  303.8  4918.441 0.152
#> 26 rowcond migrant       1 books       1 female        0  151.4  2328.836 0.298
#> 27 rowcond migrant       1 books       2 female        0  178.0  2683.693 0.344
#> 28 rowcond migrant       1 books       3 female        0  136.2  1916.525 0.245
#> 29 rowcond migrant       1 books       4 female        0   31.8   415.302 0.053
#> 30 rowcond migrant       1 books       5 female        0   33.6   467.407 0.060
#> 31 rowcond migrant       0 books       1 female        1   71.2  1270.661 0.042
#> 32 rowcond migrant       0 books       2 female        1  385.0  6870.760 0.225
#> 33 rowcond migrant       0 books       3 female        1  715.0 12483.328 0.410
#> 34 rowcond migrant       0 books       4 female        1  355.2  6051.650 0.199
#> 35 rowcond migrant       0 books       5 female        1  230.6  3805.948 0.125
#> 36 rowcond migrant       1 books       1 female        1   98.8  1360.369 0.176
#> 37 rowcond migrant       1 books       2 female        1  216.0  3082.630 0.399
#> 38 rowcond migrant       1 books       3 female        1  143.0  2206.482 0.286
#> 39 rowcond migrant       1 books       4 female        1   28.2   411.067 0.053
#> 40 rowcond migrant       1 books       5 female        1   36.4   660.327 0.086
#> 41 colcond migrant       0 books       1 female        0  162.6  2929.601 0.557
#> 42 colcond migrant       0 books       2 female        0  434.2  7965.610 0.748
#> 43 colcond migrant       0 books       3 female        0  663.4 11627.561 0.858
#> 44 colcond migrant       0 books       4 female        0  293.6  4876.792 0.922
#> 45 colcond migrant       0 books       5 female        0  303.8  4918.441 0.913
#> 46 colcond migrant       1 books       1 female        0  151.4  2328.836 0.443
#> 47 colcond migrant       1 books       2 female        0  178.0  2683.693 0.252
#> 48 colcond migrant       1 books       3 female        0  136.2  1916.525 0.142
#> 49 colcond migrant       1 books       4 female        0   31.8   415.302 0.078
#> 50 colcond migrant       1 books       5 female        0   33.6   467.407 0.087
#> 51 colcond migrant       0 books       1 female        1   71.2  1270.661 0.483
#> 52 colcond migrant       0 books       2 female        1  385.0  6870.760 0.690
#> 53 colcond migrant       0 books       3 female        1  715.0 12483.328 0.850
#> 54 colcond migrant       0 books       4 female        1  355.2  6051.650 0.936
#> 55 colcond migrant       0 books       5 female        1  230.6  3805.948 0.852
#> 56 colcond migrant       1 books       1 female        1   98.8  1360.369 0.517
#> 57 colcond migrant       1 books       2 female        1  216.0  3082.630 0.310
#> 58 colcond migrant       1 books       3 female        1  143.0  2206.482 0.150
#> 59 colcond migrant       1 books       4 female        1   28.2   411.067 0.064
#> 60 colcond migrant       1 books       5 female        1   36.4   660.327 0.148
#>       SE   fmi     df VarMI VarRep
#> 1  0.007 0.011    Inf     0  0.000
#> 2  0.011 0.033    Inf     0  0.000
#> 3  0.013 0.018    Inf     0  0.000
#> 4  0.008 0.026    Inf     0  0.000
#> 5  0.011 0.015    Inf     0  0.000
#> 6  0.007 0.034    Inf     0  0.000
#> 7  0.009 0.012    Inf     0  0.000
#> 8  0.005 0.032    Inf     0  0.000
#> 9  0.002 0.034    Inf     0  0.000
#> 10 0.002 0.101 388.46     0  0.000
#> 11 0.007 0.011    Inf     0  0.000
#> 12 0.011 0.035    Inf     0  0.000
#> 13 0.015 0.005    Inf     0  0.000
#> 14 0.011 0.019    Inf     0  0.000
#> 15 0.009 0.031    Inf     0  0.000
#> 16 0.004 0.020    Inf     0  0.000
#> 17 0.009 0.009    Inf     0  0.000
#> 18 0.007 0.026    Inf     0  0.000
#> 19 0.003 0.023    Inf     0  0.000
#> 20 0.003 0.018    Inf     0  0.000
#> 21 0.009 0.013    Inf     0  0.000
#> 22 0.013 0.032    Inf     0  0.000
#> 23 0.015 0.025    Inf     0  0.000
#> 24 0.009 0.027    Inf     0  0.000
#> 25 0.012 0.014    Inf     0  0.000
#> 26 0.024 0.102 382.83     0  0.001
#> 27 0.031 0.013    Inf     0  0.001
#> 28 0.022 0.038    Inf     0  0.000
#> 29 0.011 0.024    Inf     0  0.000
#> 30 0.013 0.076 699.03     0  0.000
#> 31 0.009 0.010    Inf     0  0.000
#> 32 0.014 0.025    Inf     0  0.000
#> 33 0.016 0.014    Inf     0  0.000
#> 34 0.013 0.028    Inf     0  0.000
#> 35 0.011 0.028    Inf     0  0.000
#> 36 0.017 0.016    Inf     0  0.000
#> 37 0.030 0.003    Inf     0  0.001
#> 38 0.026 0.038    Inf     0  0.001
#> 39 0.013 0.022    Inf     0  0.000
#> 40 0.018 0.020    Inf     0  0.000
#> 41 0.034 0.047    Inf     0  0.001
#> 42 0.028 0.018    Inf     0  0.001
#> 43 0.014 0.039    Inf     0  0.000
#> 44 0.015 0.043    Inf     0  0.000
#> 45 0.017 0.117 290.86     0  0.000
#> 46 0.034 0.047    Inf     0  0.001
#> 47 0.028 0.018    Inf     0  0.001
#> 48 0.014 0.039    Inf     0  0.000
#> 49 0.015 0.043    Inf     0  0.000
#> 50 0.017 0.117 290.86     0  0.000
#> 51 0.065 0.022    Inf     0  0.004
#> 52 0.025 0.030    Inf     0  0.001
#> 53 0.018 0.020    Inf     0  0.000
#> 54 0.015 0.013    Inf     0  0.000
#> 55 0.027 0.010    Inf     0  0.001
#> 56 0.065 0.022    Inf     0  0.004
#> 57 0.025 0.030    Inf     0  0.001
#> 58 0.018 0.020    Inf     0  0.000
#> 59 0.015 0.013    Inf     0  0.000
#> 60 0.027 0.010    Inf     0  0.001
#> 
#> Marginal Probabilities
#>       prob     var varval  group groupval   est    SE   fmi  df VarMI VarRep
#> 1  rowmarg migrant      0 female        0 0.805 0.014 0.006 Inf     0      0
#> 2  rowmarg migrant      1 female        0 0.195 0.014 0.006 Inf     0      0
#> 3  rowmarg migrant      0 female        1 0.798 0.014 0.015 Inf     0      0
#> 4  rowmarg migrant      1 female        1 0.202 0.014 0.015 Inf     0      0
#> 5  colmarg   books      1 female        0 0.131 0.011 0.007 Inf     0      0
#> 6  colmarg   books      2 female        0 0.265 0.013 0.020 Inf     0      0
#> 7  colmarg   books      3 female        0 0.338 0.013 0.010 Inf     0      0
#> 8  colmarg   books      4 female        0 0.132 0.008 0.018 Inf     0      0
#> 9  colmarg   books      5 female        0 0.134 0.011 0.010 Inf     0      0
#> 10 colmarg   books      1 female        1 0.069 0.008 0.002 Inf     0      0
#> 11 colmarg   books      2 female        1 0.261 0.015 0.011 Inf     0      0
#> 12 colmarg   books      3 female        1 0.385 0.013 0.009 Inf     0      0
#> 13 colmarg   books      4 female        1 0.169 0.011 0.027 Inf     0      0
#> 14 colmarg   books      5 female        1 0.117 0.009 0.039 Inf     0      0
#> 
#> Effect Sizes
#>        parm  group groupval    est    SE   fmi     df VarMI VarRep
#> 1         w female        0  0.291 0.022 0.128 244.47     0  0.000
#> 2         w female        1  0.300 0.036 0.024    Inf     0  0.001
#> 3         V female        0  0.291 0.022 0.128 244.47     0  0.000
#> 4         V female        1  0.300 0.036 0.024    Inf     0  0.001
#> 5     gamma female        0 -0.485 0.033 0.115 301.63     0  0.001
#> 6     gamma female        1 -0.467 0.054 0.009    Inf     0  0.003
#> 7    lambda female        0  0.022 0.011 0.009    Inf     0  0.000
#> 8  lambda_X female        0  0.000 0.000 0.000    Inf     0  0.000
#> 9  lambda_Y female        0  0.029 0.014 0.009    Inf     0  0.000
#> 10   lambda female        1  0.031 0.020 0.024    Inf     0  0.000
#> 11 lambda_X female        1  0.012 0.041 0.025    Inf     0  0.002
#> 12 lambda_Y female        1  0.037 0.017 0.015    Inf     0  0.000
#> 13      tau female        0  0.037 0.006 0.095 439.20     0  0.000
#> 14    tau_X female        0  0.085 0.013 0.128 243.88     0  0.000
#> 15    tau_Y female        0  0.017 0.003 0.088 515.56     0  0.000
#> 16      tau female        1  0.040 0.010 0.027    Inf     0  0.000
#> 17    tau_X female        1  0.090 0.022 0.023    Inf     0  0.000
#> 18    tau_Y female        1  0.019 0.005 0.027    Inf     0  0.000
```

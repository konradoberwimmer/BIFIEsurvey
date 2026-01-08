# Correlations and Covariances

Computes correlations and covariances

## Usage

``` r
BIFIE.correl(BIFIEobj, vars, group=NULL, group_values=NULL, se=TRUE)

# S3 method for class 'BIFIE.correl'
summary(object,digits=4, ...)

# S3 method for class 'BIFIE.correl'
coef(object,type=NULL, ...)

# S3 method for class 'BIFIE.correl'
vcov(object,type=NULL, ...)
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

  Object of class `BIFIE.correl`

- digits:

  Number of digits for rounding output

- type:

  If `type="cov"`, then covariances instead of correlations are
  extracted.

- ...:

  Further arguments to be passed

## Value

A list with following entries

- stat.cor:

  Data frame with correlation statistics

- stat.cov:

  Data frame with covariance statistics

- cor_matrix:

  List of estimated correlation matrices

- cov_matrix:

  List of estimated covariance matrices

- output:

  Extensive output with all replicated statistics

- ...:

  More values

## See also

[`stats::cov.wt`](https://rdrr.io/r/stats/cov.wt.html),
[`intsvy::timss.rho`](https://rdrr.io/pkg/intsvy/man/timss.rho.html),
[`intsvy::timss.rho.pv`](https://rdrr.io/pkg/intsvy/man/timss.rho.pv.html),
[`Hmisc::rcorr`](https://rdrr.io/pkg/Hmisc/man/rcorr.html),
[`miceadds::ma.wtd.corNA`](https://rdrr.io/pkg/miceadds/man/ma.wtd.statNA.html)

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

# Correlations splitted by gender
res1 <- BIFIEsurvey::BIFIE.correl( bdat, vars=c("lang", "books", "migrant" ),
              group="female", group_values=0:1 )
#> |*****|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.correl'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.correl(BIFIEobj = bdat, vars = c("lang", "books", 
#>     "migrant"), group = "female", group_values = 0:1)
#> 
#> Date of Analysis: 2026-01-08 12:35:34.604048 
#> Time difference of 0.1909266 secs
#> Computation time: 0.1909266 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Statistical Inference for Correlations 
#>     var1    var2 groupvar groupval Ncases  Nweight     cor cor_SE      t     df
#> 3   lang   books   female        0 2388.6 40129.77 -0.1649 0.0305  -5.41    Inf
#> 4   lang   books   female        1 2279.4 38203.22 -0.1877 0.0370  -5.07    Inf
#> 5   lang migrant   female        0 2388.6 40129.77  0.5873 0.0286  20.55    Inf
#> 6   lang migrant   female        1 2279.4 38203.22  0.5953 0.0279  21.32    Inf
#> 9  books migrant   female        0 2388.6 40129.77 -0.2619 0.0209 -12.53 472.26
#> 10 books migrant   female        1 2279.4 38203.22 -0.2473 0.0326  -7.59    Inf
#>    p cor_fmi cor_VarMI cor_VarRep
#> 3  0  0.0212         0     0.0009
#> 4  0  0.0229         0     0.0013
#> 5  0  0.0583         0     0.0008
#> 6  0  0.0151         0     0.0008
#> 9  0  0.0920         0     0.0004
#> 10 0  0.0142         0     0.0010
#> 
#> Correlation Matrices 
#> 
#> $female0
#>            lang   books migrant
#> lang     1.0000 -0.1649  0.5873
#> books   -0.1649  1.0000 -0.2619
#> migrant  0.5873 -0.2619  1.0000
#> 
#> $female1
#>            lang   books migrant
#> lang     1.0000 -0.1877  0.5953
#> books   -0.1877  1.0000 -0.2473
#> migrant  0.5953 -0.2473  1.0000
#> 

# Correlations splitted by gender: no statistical inference (se=FALSE)
res1a <- BIFIEsurvey::BIFIE.correl( bdat, vars=c("lang", "books", "migrant" ),
              group="female", group_values=0:1, se=FALSE)
#> |*****|
#> |-----|
summary(res1a)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.correl'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.correl(BIFIEobj = bdat, vars = c("lang", "books", 
#>     "migrant"), group = "female", group_values = 0:1, se = FALSE)
#> 
#> Date of Analysis: 2026-01-08 12:35:34.800124 
#> Time difference of 0.008262157 secs
#> Computation time: 0.008262157 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 0 
#> Fay factor = 1 
#> 
#> Statistical Inference for Correlations 
#>     var1    var2 groupvar groupval Ncases  Nweight     cor
#> 3   lang   books   female        0 2388.6 40129.77 -0.1649
#> 4   lang   books   female        1 2279.4 38203.22 -0.1877
#> 5   lang migrant   female        0 2388.6 40129.77  0.5873
#> 6   lang migrant   female        1 2279.4 38203.22  0.5953
#> 9  books migrant   female        0 2388.6 40129.77 -0.2619
#> 10 books migrant   female        1 2279.4 38203.22 -0.2473
#> 
#> Correlation Matrices 
#> 
#> $female0
#>            lang   books migrant
#> lang     1.0000 -0.1649  0.5873
#> books   -0.1649  1.0000 -0.2619
#> migrant  0.5873 -0.2619  1.0000
#> 
#> $female1
#>            lang   books migrant
#> lang     1.0000 -0.1877  0.5953
#> books   -0.1877  1.0000 -0.2473
#> migrant  0.5953 -0.2473  1.0000
#> 
```

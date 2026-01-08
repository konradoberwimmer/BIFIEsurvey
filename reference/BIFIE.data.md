# Creates an Object of Class `BIFIEdata`

This function creates an object of class `BIFIEdata`. Finite sampling
correction of statistical inferences can be conducted by specifying
appropriate input in the `fayfac` argument.

## Usage

``` r
BIFIE.data(data.list, wgt=NULL, wgtrep=NULL, fayfac=1, pv_vars=NULL,
     pvpre=NULL, cdata=FALSE, NMI=FALSE)

# S3 method for class 'BIFIEdata'
summary(object,...)

# S3 method for class 'BIFIEdata'
print(x,...)
```

## Arguments

- data.list:

  List of multiply imputed datasets. Can be also a list of list of
  imputed datasets in case of nested multiple imputation. Then, the
  argument `NMI=TRUE` must be specified.

- wgt:

  A string indicating the label of case weight or a vector containing
  all case weights.

- wgtrep:

  Optional vector of replicate weights

- fayfac:

  Fay factor for calculating standard errors, a numeric value. If finite
  sampling correction is requested, an appropriate vector input can be
  used (see Example 3).

- pv_vars:

  Optional vector for names of plausible values, see
  [`BIFIE.data.jack`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.jack.md).

- pvpre:

  Optional vector for prefixes of plausible values, see
  [`BIFIE.data.jack`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.jack.md).

- cdata:

  An optional logical indicating whether the `BIFIEdata` object should
  be compactly saved. The default is `FALSE`.

- NMI:

  Optional logical indicating whether `data.list` is obtained by nested
  multiple imputation.

- object:

  Object of class `BIFIEdata`

- x:

  Object of class `BIFIEdata`

- ...:

  Further arguments to be passed

## Value

An object of class `BIFIEdata` saved in a non-compact or compact way,
see value `cdata`. The following entries are included in the list:

- datalistM:

  Stacked list of imputed datasets (if `cdata=FALSE`)

- wgt:

  Vector with case weights

- wgtrep:

  Matrix with replicate weights

- Nimp:

  Number of imputed datasets

- N:

  Number of observations in a dataset

- dat1:

  Last imputed dataset

- varnames:

  Vector with variable names

- fayfac:

  Fay factor.

- RR:

  Number of replicate weights

- NMI:

  Logical indicating whether the dataset is nested multiply imputed.

- cdata:

  Logical indicating whether the `BIFIEdata` object is in compact format
  (`cdata=TRUE`) or in a non-compact format (`cdata=FALSE`).

- Nvars:

  Number of variables

- variables:

  Data frame including some informations about variables. All
  transformations are saved in the column `source`.

- datalistM_ind:

  Data frame with response indicators (if `cdata=TRUE`)

- datalistM_imputed:

  Data frame with imputed values (if `cdata=TRUE`)

## See also

See
[`BIFIE.data.transform`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.transform.md)
for data transformations on `BIFIEdata` objects.

For saving and loading `BIFIEdata` objects see
[`save.BIFIEdata`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/save.BIFIEdata.md).

For converting PIRLS/TIMSS or PISA datasets into `BIFIEdata` objects see
[`BIFIE.data.jack`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.jack.md).

See the
[`BIFIEdata2svrepdesign`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIEdata2svrepdesign.md)
function for converting `BIFIEdata` objects to objects used in the
survey package.

## Examples

``` r
#############################################################################
# EXAMPLE 1: Create BIFIEdata object with multiply-imputed TIMSS data
#############################################################################
data(data.timss1)
data(data.timssrep)

bdat <- BIFIEsurvey::BIFIE.data( data.list=data.timss1, wgt=data.timss1[[1]]$TOTWGT,
            wgtrep=data.timssrep[, -1 ] )
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|
summary(bdat)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data(data.list = data.timss1, wgt = data.timss1[[1]]$TOTWGT, 
#>     wgtrep = data.timssrep[, -1])
#> 
#> Date of Analysis: 2026-01-08 12:35:46.491905 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of variables = 13 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Object size: 
#>   Total:  5.5 MB | 0.00537 GB 
#>    $datalistM : 2.315 MB | 0.00226 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.464 MB | 0.00045 GB 
#>    $wgtrep : 2.677 MB | 0.00261 GB 
# create BIFIEdata object in a compact way
bdat2 <- BIFIEsurvey::BIFIE.data( data.list=data.timss1, wgt=data.timss1[[1]]$TOTWGT,
            wgtrep=data.timssrep[, -1 ], cdata=TRUE)
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|
summary(bdat2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data(data.list = data.timss1, wgt = data.timss1[[1]]$TOTWGT, 
#>     wgtrep = data.timssrep[, -1], cdata = TRUE)
#> Compact BIFIEdata
#> 
#> Date of Analysis: 2026-01-08 12:35:46.503116 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of variables = 13 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Object size: 
#>   Total:  4.098 MB | 0.004 GB 
#>    $datalistM : 0 MB | 0 GB 
#>    $datalistM_ind : 0.464 MB | 0.00045 GB 
#>    $datalistM_imputed : 0.374 MB | 0.00037 GB 
#>    $datalistM_impindex : 0.075 MB | 7e-05 GB 
#>    $dat1 : 0.464 MB | 0.00045 GB 
#>    $wgtrep : 2.677 MB | 0.00261 GB 

if (FALSE) { # \dontrun{
#############################################################################
# EXAMPLE 2: Create BIFIEdata object with one dataset
#############################################################################
data(data.timss2)

# use first dataset with missing data from data.timss2
bdat <- BIFIEsurvey::BIFIE.data( data.list=data.timss2[[1]], wgt=data.timss2[[1]]$TOTWGT)
} # }

#############################################################################
# EXAMPLE 3: BIFIEdata objects with finite sampling correction
#############################################################################

data(data.timss1)
data(data.timssrep)

#-----
# BIFIEdata object without finite sampling correction
bdat1 <- BIFIEsurvey::BIFIE.data( data.list=data.timss1, wgt=data.timss1[[1]]$TOTWGT,
            wgtrep=data.timssrep[, -1 ] )
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|
summary(bdat1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data(data.list = data.timss1, wgt = data.timss1[[1]]$TOTWGT, 
#>     wgtrep = data.timssrep[, -1])
#> 
#> Date of Analysis: 2026-01-08 12:35:46.535277 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of variables = 13 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Object size: 
#>   Total:  5.5 MB | 0.00537 GB 
#>    $datalistM : 2.315 MB | 0.00226 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.464 MB | 0.00045 GB 
#>    $wgtrep : 2.677 MB | 0.00261 GB 

#-----
# generate BIFIEdata object with finite sampling correction by adjusting
# the "fayfac" factor
bdat2 <- bdat1
#-- modify "fayfac" constant
fayfac0 <- bdat1$fayfac
# set fayfac=.75 for the first 50 replication zones (25% of students in the
# population were sampled) and fayfac=.20 for replication zones 51-75
# (meaning that 80% of students were sampled)
fayfac <- rep( fayfac0, bdat1$RR )
fayfac[1:50] <- fayfac0 * .75
fayfac[51:75] <- fayfac0 * .20
# include this modified "fayfac" factor in bdat2
bdat2$fayfac <- fayfac
summary(bdat2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data(data.list = data.timss1, wgt = data.timss1[[1]]$TOTWGT, 
#>     wgtrep = data.timssrep[, -1])
#> 
#> Date of Analysis: 2026-01-08 12:35:46.535277 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of variables = 13 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor: M = 0.56667 | SD = 0.26102 
#> 
#> Object size: 
#>   Total:  5.5 MB | 0.00537 GB 
#>    $datalistM : 2.315 MB | 0.00226 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.464 MB | 0.00045 GB 
#>    $wgtrep : 2.677 MB | 0.00261 GB 
summary(bdat1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data(data.list = data.timss1, wgt = data.timss1[[1]]$TOTWGT, 
#>     wgtrep = data.timssrep[, -1])
#> 
#> Date of Analysis: 2026-01-08 12:35:46.535277 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of variables = 13 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Object size: 
#>   Total:  5.5 MB | 0.00537 GB 
#>    $datalistM : 2.315 MB | 0.00226 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.464 MB | 0.00045 GB 
#>    $wgtrep : 2.677 MB | 0.00261 GB 

#---- compare some univariate statistics
# no finite sampling correction
res1 <- BIFIEsurvey::BIFIE.univar( bdat1, vars="ASMMAT")
#> |*****|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat1, vars = "ASMMAT")
#> 
#> Date of Analysis: 2026-01-08 12:35:46.545487 
#> Time difference of 0.02249336 secs
#> Computation time: 0.02249336 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Univariate Statistics | Means
#>      var  Nweight Ncases       M  M_SE M_df     M_t M_p M_fmi M_VarMI M_VarRep
#> 1 ASMMAT 78332.99   4668 508.311 2.617  Inf 194.268   0  0.05   0.284    6.505
#> 
#> Univariate Statistics | Standard Deviations
#>      var  Nweight Ncases     SD SD_SE SD_df    SD_t SD_p
#> 1 ASMMAT 78332.99   4668 62.696 1.088 57.07 467.401    0
# finite sampling correction
res2 <- BIFIEsurvey::BIFIE.univar( bdat2, vars="ASMMAT")
#> |*****|
#> |-----|
summary(res2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat2, vars = "ASMMAT")
#> 
#> Date of Analysis: 2026-01-08 12:35:46.5749 
#> Time difference of 0.02695823 secs
#> Computation time: 0.02695823 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.75 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 
#> 
#> Univariate Statistics | Means
#>      var  Nweight Ncases       M  M_SE   M_df     M_t M_p M_fmi M_VarMI
#> 1 ASMMAT 78332.99   4668 508.311 2.044 599.25 248.735   0 0.082   0.284
#>   M_VarRep
#> 1    3.835
#> 
#> Univariate Statistics | Standard Deviations
#>      var  Nweight Ncases     SD SD_SE SD_df    SD_t SD_p
#> 1 ASMMAT 78332.99   4668 62.696 0.892 25.79 570.074    0

if (FALSE) { # \dontrun{
#############################################################################
# EXAMPLE 4: Create BIFIEdata object with nested multiply imputed dataset
#############################################################################

data(data.timss4)
data(data.timssrep)

# nested imputed dataset, save it in compact format
bdat <- BIFIEsurvey::BIFIE.data( data.list=data.timss4,
            wgt=data.timss4[[1]][[1]]$TOTWGT, wgtrep=data.timssrep[, -1 ],
            NMI=TRUE, cdata=TRUE )
summary(bdat)
} # }
```

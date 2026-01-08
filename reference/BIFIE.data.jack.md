# Create `BIFIE.data` Object with Jackknife Zones

Creates a `BIFIE.data` object for designs with jackknife zones,
especially for TIMSS/PIRLS and PISA studies.

## Usage

``` r
BIFIE.data.jack(data, wgt=NULL, jktype="JK_TIMSS", pv_vars=NULL,
     jkzone=NULL, jkrep=NULL, jkfac=NULL, fayfac=NULL,
     wgtrep="W_FSTR", pvpre=paste0("PV",1:5), ngr=100,
     seed=.Random.seed, cdata=FALSE)
```

## Arguments

- data:

  Data frame: Can be a single or a list of multiply-imputed datasets

- wgt:

  A string indicating the label of case weight. In case of
  `jktype="JK_TIMSS"` the weight is specified as `wgt="TOTWGT"` as the
  default.

- pv_vars:

  An optional vector of plausible values which define multiply-imputed
  datasets.

- jktype:

  Type of jackknife procedure for creating the `BIFIE.data` object.
  `jktype="JK_TIMSS"` refers to TIMSS/PIRLS datasets up to 2011 data,
  `jktype="JK_TIMSS2"` refers to TIMSS/PIRLS datasets starting from 2015
  data. The type `"JK_GROUP"` creates jackknife weights based on a user
  defined grouping, the type `"JK_RANDOM"` creates random groups. The
  number of random groups can be defined in `ngr`. The argument
  `jktype="RW_PISA"` converts PISA datasets into objects of class
  `BIFIEdata`.

- jkzone:

  Jackknife zones. If `jktype="JK_TIMSS"`, then `jkzone="JKZONE"`.

- jkrep:

  Jackknife replicate factors. If `jktype="JK_TIMSS"`, then
  `jkrep="JKREP"`.

- jkfac:

  Factor for multiplying jackknife replicate weights. If
  `jktype="JK_TIMSS"`, then `jkfac=2`.

- fayfac:

  Fay factor for statistical inference. The default is set to `NULL`.

- wgtrep:

  Variables in the dataset which refer to the replicate weights. In case
  of `cdata=TRUE`, the replicate weights are deleted from `datalistM`.

- pvpre:

  Only applicable for `jktype="RW_PISA"`. The vector contains the
  prefixes of the variables containing plausible values.

- ngr:

  Number of randomly created groups in `"JK_RANDOM"`.

- seed:

  The simulation seed if `"JK_RANDOM"` is chosen. If `seed=NULL`, then
  the grouping is done according the order in the dataset.

- cdata:

  An optional logical indicating whether the `BIFIEdata` object should
  be compactly saved. The default is `FALSE`.

## Value

Object of class `BIFIEdata`

## See also

[`BIFIE.data`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.md),
[`BIFIE.data.boot`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.boot.md)

## Examples

``` r
#############################################################################
# EXAMPLE 1: Convert TIMSS dataset to BIFIE.data object
#############################################################################

data(data.timss3)

# define plausible values
pv_vars <- c("ASMMAT", "ASSSCI" )
# create BIFIE.data objects -> 5 imputed datasets
bdat1 <- BIFIEsurvey::BIFIE.data.jack( data=data.timss3,  pv_vars=pv_vars,
             jktype="JK_TIMSS"  )
#> +++ Generate replicate weights
#> |**********|
#> |----------|
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|
summary(bdat1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data.jack(data = data.timss3, jktype = "JK_TIMSS", 
#>     pv_vars = pv_vars)
#> 
#> Date of Analysis: 2026-01-08 12:41:06.591377 
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
#>   Total:  5.499 MB | 0.00537 GB 
#>    $datalistM : 2.315 MB | 0.00226 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.464 MB | 0.00045 GB 
#>    $wgtrep : 2.677 MB | 0.00261 GB 

# create BIFIE.data objects -> all PVs are included in one dataset
bdat2 <- BIFIEsurvey::BIFIE.data.jack( data=data.timss3,  jktype="JK_TIMSS"  )
#> +++ Generate replicate weights
#> |**********|
#> |----------|
#> +++ Generate BIFIE.data object
#> |*|
#> |-|
summary(bdat2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data.jack(data = data.timss3, jktype = "JK_TIMSS")
#> 
#> Date of Analysis: 2026-01-08 12:41:06.597823 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of variables = 21 
#> Number of imputed datasets = 1 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Object size: 
#>   Total:  4.218 MB | 0.00412 GB 
#>    $datalistM : 0.748 MB | 0.00073 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.75 MB | 0.00073 GB 
#>    $wgtrep : 2.677 MB | 0.00261 GB 

#############################################################################
# EXAMPLE 2: Creation of Jackknife zones and replicate weights for data.test1
#############################################################################

data(data.test1)

# create jackknife zones based on random group creation
bdat1 <- BIFIEsurvey::BIFIE.data.jack( data=data.test1,  jktype="JK_RANDOM",
                    ngr=50 )
#> +++ Generate replicate weights
#> |**********|
#> |----------|
#> +++ Generate BIFIE.data object
#> |*|
#> |-|
summary(bdat1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data.jack(data = data.test1, jktype = "JK_RANDOM", 
#>     ngr = 50)
#> 
#> Date of Analysis: 2026-01-08 12:41:06.606332 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 2101 
#> Number of variables = 17 
#> Number of imputed datasets = 1 
#> Number of Jackknife zones per dataset = 50 
#> Fay factor = 1.02041 
#> 
#> Object size: 
#>   Total:  1.504 MB | 0.00147 GB 
#>    $datalistM : 0.273 MB | 0.00027 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.402 MB | 0.00039 GB 
#>    $wgtrep : 0.805 MB | 0.00079 GB 
stat1 <- BIFIEsurvey::BIFIE.univar( bdat1, vars="math",  group="stratum" )
#> |*|
#> |-|
summary(stat1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat1, vars = "math", group = "stratum")
#> 
#> Date of Analysis: 2026-01-08 12:41:06.609435 
#> Time difference of 0.003631353 secs
#> Computation time: 0.003631353 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 2101 
#> Number of imputed datasets = 1 
#> Number of Jackknife zones per dataset = 50 
#> Fay factor = 1.02041 
#> 
#> Univariate Statistics | Means
#>    var groupvar groupval Nweight Ncases       M  M_SE M_df     M_t M_p M_VarRep
#> 1 math  stratum        1     499    499 120.597 1.046   NA 115.346  NA    1.093
#> 2 math  stratum        2     592    592 116.606 1.240   NA  94.069  NA    1.537
#> 3 math  stratum        3     658    658  96.631 1.068   NA  90.489  NA    1.140
#> 4 math  stratum        4     352    352  79.616 1.647   NA  48.328  NA    2.714
#> 
#> Univariate Statistics | Standard Deviations
#>    var groupvar groupval Nweight Ncases     SD SD_SE SD_df    SD_t SD_p
#> 1 math  stratum        1     499    499 24.676 0.936    NA 128.869   NA
#> 2 math  stratum        2     592    592 28.737 1.171    NA  99.562   NA
#> 3 math  stratum        3     658    658 30.100 0.977    NA  98.905   NA
#> 4 math  stratum        4     352    352 27.763 1.263    NA  63.022   NA
#>   SD_VarRep
#> 1     0.876
#> 2     1.372
#> 3     0.955
#> 4     1.596

# random creation of groups and inclusion of weights
bdat2 <- BIFIEsurvey::BIFIE.data.jack( data=data.test1,  jktype="JK_RANDOM",
                ngr=75, seed=987, wgt="wgtstud")
#> +++ Generate replicate weights
#> |**********|
#> |----------|
#> +++ Generate BIFIE.data object
#> |*|
#> |-|
summary(bdat2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data.jack(data = data.test1, wgt = "wgtstud", 
#>     jktype = "JK_RANDOM", ngr = 75, seed = 987)
#> 
#> Date of Analysis: 2026-01-08 12:41:06.628464 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 2101 
#> Number of variables = 17 
#> Number of imputed datasets = 1 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1.01351 
#> 
#> Object size: 
#>   Total:  1.907 MB | 0.00186 GB 
#>    $datalistM : 0.273 MB | 0.00027 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.402 MB | 0.00039 GB 
#>    $wgtrep : 1.208 MB | 0.00118 GB 
stat2 <- BIFIEsurvey::BIFIE.univar( bdat2, vars="math",  group="stratum" )
#> |*|
#> |-|
summary(stat2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat2, vars = "math", group = "stratum")
#> 
#> Date of Analysis: 2026-01-08 12:41:06.630736 
#> Time difference of 0.003576279 secs
#> Computation time: 0.003576279 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 2101 
#> Number of imputed datasets = 1 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1.01351 
#> 
#> Univariate Statistics | Means
#>    var groupvar groupval Nweight Ncases       M  M_SE M_df     M_t M_p M_VarRep
#> 1 math  stratum        1   10000    499 121.368 1.199   NA 101.257  NA    1.437
#> 2 math  stratum        2   10000    592 115.877 1.266   NA  91.565  NA    1.602
#> 3 math  stratum        3   45000    658  97.172 0.985   NA  98.670  NA    0.970
#> 4 math  stratum        4   10000    352  78.545 1.763   NA  44.551  NA    3.108
#> 
#> Univariate Statistics | Standard Deviations
#>    var groupvar groupval Nweight Ncases     SD SD_SE SD_df    SD_t SD_p
#> 1 math  stratum        1   10000    499 24.527 0.924    NA 131.306   NA
#> 2 math  stratum        2   10000    592 28.387 0.991    NA 116.918   NA
#> 3 math  stratum        3   45000    658 29.557 0.990    NA  98.174   NA
#> 4 math  stratum        4   10000    352 27.920 1.061    NA  74.009   NA
#>   SD_VarRep
#> 1     0.854
#> 2     0.982
#> 3     0.980
#> 4     1.126

# using idclass as jackknife zones
bdat3 <- BIFIEsurvey::BIFIE.data.jack( data=data.test1,  jktype="JK_GROUP",
                jkzone="idclass", wgt="wgtstud")
#> +++ Generate replicate weights
#> |**********|
#> |----------|
#> +++ Generate BIFIE.data object
#> |*|
#> |-|
summary(bdat3)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data.jack(data = data.test1, wgt = "wgtstud", 
#>     jktype = "JK_GROUP", jkzone = "idclass")
#> 
#> Date of Analysis: 2026-01-08 12:41:06.641391 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 2101 
#> Number of variables = 17 
#> Number of imputed datasets = 1 
#> Number of Jackknife zones per dataset = 89 
#> Fay factor = 1.0101 
#> 
#> Object size: 
#>   Total:  2.132 MB | 0.00208 GB 
#>    $datalistM : 0.273 MB | 0.00027 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.402 MB | 0.00039 GB 
#>    $wgtrep : 1.433 MB | 0.0014 GB 
stat3 <- BIFIEsurvey::BIFIE.univar( bdat3, vars="math",  group="stratum" )
#> |*|
#> |-|
summary(stat3)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat3, vars = "math", group = "stratum")
#> 
#> Date of Analysis: 2026-01-08 12:41:06.643639 
#> Time difference of 0.003797531 secs
#> Computation time: 0.003797531 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 2101 
#> Number of imputed datasets = 1 
#> Number of Jackknife zones per dataset = 89 
#> Fay factor = 1.0101 
#> 
#> Univariate Statistics | Means
#>    var groupvar groupval Nweight Ncases       M  M_SE M_df    M_t M_p M_VarRep
#> 1 math  stratum        1   10000    499 121.368 2.641   NA 45.961  NA    6.973
#> 2 math  stratum        2   10000    592 115.877 3.209   NA 36.112  NA   10.297
#> 3 math  stratum        3   45000    658  97.172 2.542   NA 38.222  NA    6.463
#> 4 math  stratum        4   10000    352  78.545 3.971   NA 19.779  NA   15.769
#> 
#> Univariate Statistics | Standard Deviations
#>    var groupvar groupval Nweight Ncases     SD SD_SE SD_df    SD_t SD_p
#> 1 math  stratum        1   10000    499 24.527 0.915    NA 132.674   NA
#> 2 math  stratum        2   10000    592 28.387 1.609    NA  72.015   NA
#> 3 math  stratum        3   45000    658 29.557 1.255    NA  77.415   NA
#> 4 math  stratum        4   10000    352 27.920 1.832    NA  42.870   NA
#>   SD_VarRep
#> 1     0.837
#> 2     2.589
#> 3     1.576
#> 4     3.357

# create BIFIEdata object with a list of imputed datasets
dataList <- list( data.test1, data.test1, data.test1 )
bdat4 <- BIFIEsurvey::BIFIE.data.jack( data=dataList,  jktype="JK_GROUP",
                jkzone="idclass", wgt="wgtstud")
#> +++ Generate replicate weights
#> |**********|
#> |----------|
#> +++ Generate BIFIE.data object
#> |***|
#> |---|
summary(bdat4)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data.jack(data = dataList, wgt = "wgtstud", 
#>     jktype = "JK_GROUP", jkzone = "idclass")
#> 
#> Date of Analysis: 2026-01-08 12:41:06.6555 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 2101 
#> Number of variables = 17 
#> Number of imputed datasets = 3 
#> Number of Jackknife zones per dataset = 89 
#> Fay factor = 1.0101 
#> 
#> Object size: 
#>   Total:  2.677 MB | 0.00261 GB 
#>    $datalistM : 0.818 MB | 8e-04 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.402 MB | 0.00039 GB 
#>    $wgtrep : 1.433 MB | 0.0014 GB 

if (FALSE) { # \dontrun{
#############################################################################
# EXAMPLE 3: Converting a PISA dataset into a BIFIEdata object
#############################################################################

data(data.pisaNLD)

# BIFIEdata with cdata=FALSE
bifieobj <- BIFIEsurvey::BIFIE.data.jack( data.pisaNLD, jktype="RW_PISA", cdata=FALSE)
summary(bifieobj)
# BIFIEdata with cdata=TRUE
bifieobj1 <- BIFIEsurvey::BIFIE.data.jack( data.pisaNLD, jktype="RW_PISA", cdata=TRUE)
summary(bifieobj1)
} # }
```

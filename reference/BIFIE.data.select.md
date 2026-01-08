# Selection of Variables and Imputed Datasets for Objects of Class `BIFIEdata`

This function select variables and some (or all) imputed datasets of an
object of class `BIFIEdata` and saves the resulting object also of class
`BIFIEdata`.

## Usage

``` r
BIFIEdata.select(bifieobj, varnames=NULL, impdata.index=NULL)
```

## Arguments

- bifieobj:

  Object of class `BIFIEdata`

- varnames:

  Variables chosen for the selection

- impdata.index:

  Selected indices of imputed datasets

## Value

An object of class `BIFIEdata` saved in a non-compact or compact way,
see value `cdata`

## See also

See
[`BIFIE.data`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.md)
for creating `BIFIEdata` objects.

## Examples

``` r
#############################################################################
# EXAMPLE 1: Some manipulations of BIFIEdata objects created from data.timss1
#############################################################################
data(data.timss1)
data(data.timssrep)

# create BIFIEdata
bdat1 <- BIFIEsurvey::BIFIE.data( data.list=data.timss1, wgt=data.timss1[[1]]$TOTWGT,
            wgtrep=data.timssrep[, -1 ])
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
#> Date of Analysis: 2026-01-08 12:24:43.983019 
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

# create BIFIEcdata object
bdat2 <- BIFIEsurvey::BIFIE.data( data.list=data.timss1, wgt=data.timss1[[1]]$TOTWGT,
            wgtrep=data.timssrep[, -1 ], cdata=TRUE )
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
#> Date of Analysis: 2026-01-08 12:24:44.003211 
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

# selection of variables for BIFIEdata object
bdat1a <- BIFIEsurvey::BIFIEdata.select( bdat1, varnames=bdat1$varnames[ 1:7 ] )
# selection of variables and 1st, 2nd and 4th imputed datasets of BIFIEcdata object
bdat2a <- BIFIEsurvey::BIFIEdata.select( bdat2, varnames=bdat2$varnames[ 1:7 ],
                impdata.index=c(1,2,4) )
summary(bdat1a)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data(data.list = data.timss1, wgt = data.timss1[[1]]$TOTWGT, 
#>     wgtrep = data.timssrep[, -1])
#> 
#> Date of Analysis: 2026-01-08 12:24:43.983019 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of variables = 8 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Object size: 
#>   Total:  4.43 MB | 0.00433 GB 
#>    $datalistM : 1.425 MB | 0.00139 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.286 MB | 0.00028 GB 
#>    $wgtrep : 2.677 MB | 0.00261 GB 
summary(bdat2a)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data(data.list = data.timss1, wgt = data.timss1[[1]]$TOTWGT, 
#>     wgtrep = data.timssrep[, -1], cdata = TRUE)
#> Compact BIFIEdata
#> 
#> Date of Analysis: 2026-01-08 12:24:44.003211 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of variables = 8 
#> Number of imputed datasets = 3 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Object size: 
#>   Total:  3.297 MB | 0.00322 GB 
#>    $datalistM : 0 MB | 0 GB 
#>    $datalistM_ind : 0.286 MB | 0.00028 GB 
#>    $datalistM_imputed : 0.004 MB | 0 GB 
#>    $datalistM_impindex : 0.002 MB | 0 GB 
#>    $dat1 : 0.286 MB | 0.00028 GB 
#>    $wgtrep : 2.677 MB | 0.00261 GB 
```

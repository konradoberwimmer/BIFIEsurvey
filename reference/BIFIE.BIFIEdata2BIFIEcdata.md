# Conversion and Selection of `BIFIEdata` Objects

Functions for converting and selecting objects of class `BIFIEdata`. The
function `BIFIE.BIFIEdata2BIFIEcdata` converts the `BIFIEdata` objects
in a non-compact form (`cdata=FALSE`) into an object of class
`BIFIEdata` in a compact form (`cdata=TRUE`). The function
`BIFIE.BIFIE2data2BIFIEdata` takes the reverse operation.

The function `BIFIE.BIFIEdata2datalist` converts a (part) of the object
of class `BIFIEdata` into a list of multiply-imputed datasets.

## Usage

``` r
BIFIE.BIFIEdata2BIFIEcdata(bifieobj, varnames=NULL, impdata.index=NULL)

BIFIE.BIFIEcdata2BIFIEdata(bifieobj, varnames=NULL, impdata.index=NULL)

BIFIE.BIFIEdata2datalist(bifieobj, varnames=NULL, impdata.index=NULL,
    as_data_frame=FALSE)
```

## Arguments

- bifieobj:

  Object of class `BIFIEdata`

- varnames:

  Variables chosen for the selection

- impdata.index:

  Selected indices of imputed datasets

- as_data_frame:

  Logical indicating whether list of length one should be converted into
  a data frame

## Value

An object of class `BIFIEdata` saved in a non-compact or compact way,
see value `cdata`.

## See also

[`BIFIE.data`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.md)

## Examples

``` r
#############################################################################
# EXAMPLE 1: BIFIEdata conversions using data.timss1 dataset
#############################################################################
data(data.timss1)
data(data.timssrep)

# create BIFIEdata object
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
#> Date of Analysis: 2026-01-08 12:35:27.242485 
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

# convert BIFIEdata object bdat1 into a BIFIEcdata object with
#  only using the first three datasets and a variable selection
bdat2 <- BIFIEsurvey::BIFIE.BIFIEdata2BIFIEcdata( bifieobj=bdat1,
                varnames=bdat1$varnames[ c(1:7,10) ] )

# convert bdat2 into BIFIEdata object and only use the first three imputed datasets
bdat3 <- BIFIEsurvey::BIFIE.BIFIEcdata2BIFIEdata( bifieobj=bdat2, impdata.index=1:3)

# object summaries
summary(bdat1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data(data.list = data.timss1, wgt = data.timss1[[1]]$TOTWGT, 
#>     wgtrep = data.timssrep[, -1])
#> 
#> Date of Analysis: 2026-01-08 12:35:27.242485 
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
summary(bdat2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data(data.list = data.timss1, wgt = data.timss1[[1]]$TOTWGT, 
#>     wgtrep = data.timssrep[, -1])
#> Compact BIFIEdata
#> 
#> Date of Analysis: 2026-01-08 12:35:27.248031 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of variables = 9 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Object size: 
#>   Total:  3.375 MB | 0.0033 GB 
#>    $datalistM : 0 MB | 0 GB 
#>    $datalistM_ind : 0.322 MB | 0.00031 GB 
#>    $datalistM_imputed : 0.01 MB | 1e-05 GB 
#>    $datalistM_impindex : 0.002 MB | 0 GB 
#>    $dat1 : 0.322 MB | 0.00031 GB 
#>    $wgtrep : 2.677 MB | 0.00261 GB 
summary(bdat3)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Call:
#>  BIFIEsurvey::BIFIE.data(data.list = data.timss1, wgt = data.timss1[[1]]$TOTWGT, 
#>     wgtrep = data.timssrep[, -1])
#> 
#> Date of Analysis: 2026-01-08 12:35:27.248031 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of variables = 9 
#> Number of imputed datasets = 3 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Object size: 
#>   Total:  4.003 MB | 0.00391 GB 
#>    $datalistM : 0.962 MB | 0.00094 GB 
#>    $datalistM_ind : 0 MB | 0 GB 
#>    $datalistM_imputed : 0 MB | 0 GB 
#>    $datalistM_impindex : 0 MB | 0 GB 
#>    $dat1 : 0.322 MB | 0.00031 GB 
#>    $wgtrep : 2.677 MB | 0.00261 GB 

if (FALSE) { # \dontrun{
#############################################################################
# EXAMPLE 2: Extract unique elements in BIFIEdata object
#############################################################################

data(data.timss1)
data(data.timssrep)

# create BIFIEdata object
bifieobj <- BIFIEsurvey::BIFIE.data( data.list=data.timss1, wgt=data.timss1[[1]]$TOTWGT,
            wgtrep=data.timssrep[, -1 ])
summary(bifieobj)

# define variables for which unique values should be extracted
vars <- c( "female", "books","ASMMAT" )
# convert these variables from BIFIEdata object into a list of datasets
bdatlist <- BIFIEsurvey::BIFIE.BIFIEdata2datalist( bifieobj, varnames=vars )
# look for unique values in first dataset for variables
values <- lapply( bdatlist[[1]], FUN=function(vv){
                sort( unique( vv ) ) } )
# number of unique values in first dataset
Nvalues <- lapply( bdatlist[[1]], FUN=function(vv){
                length( unique( vv ) ) } )
# number of unique values in all datasets
Nvalues2 <- lapply( vars, FUN=function(vv){
    #vv <- vars[1]
    unlist( lapply( bdatlist, FUN=function(dd){
                length( unique( dd[,vv]  ) )
                        }    )     )
                    } )
# --> for extracting the number of unique values using BIFIE.by and a user
#     defined function see Example 1, Model 3 in "BIFIE.by"
} # }
```

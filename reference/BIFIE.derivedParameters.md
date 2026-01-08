# Statistical Inference for Derived Parameters

This function performs statistical for derived parameters for objects of
classes
[`BIFIE.by`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.by.md),
[`BIFIE.correl`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.correl.md),
[`BIFIE.crosstab`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.crosstab.md),
[`BIFIE.freq`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.freq.md),
[`BIFIE.linreg`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.linreg.md),
[`BIFIE.logistreg`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.logistreg.md)
and
[`BIFIE.univar`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.univar.md).

## Usage

``` r
BIFIE.derivedParameters( BIFIE.method, derived.parameters, type=NULL)

# S3 method for class 'BIFIE.derivedParameters'
summary(object,digits=4,...)

# S3 method for class 'BIFIE.derivedParameters'
coef(object,...)

# S3 method for class 'BIFIE.derivedParameters'
vcov(object,...)
```

## Arguments

- BIFIE.method:

  Object of classes
  [`BIFIE.by`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.by.md),
  [`BIFIE.correl`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.correl.md),
  [`BIFIE.crosstab`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.crosstab.md),
  [`BIFIE.freq`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.freq.md),
  [`BIFIE.linreg`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.linreg.md),
  [`BIFIE.logistreg`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.logistreg.md)
  or
  [`BIFIE.univar`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.univar.md)
  (see `parnames` in the Output of these methods for saved parameters)

- derived.parameters:

  List with R formulas for derived parameters (see Examples for
  specification)

- type:

  Only applies to `BIFIE.correl`. In case of `type="cov"` covariances
  instead of correlations are used for derived parameters.

- object:

  Object of class `BIFIE.derivedParameters`

- digits:

  Number of digits for rounding decimals in output

- ...:

  Further arguments to be passed

## Details

The distribution of derived parameters is derived by the direct
calculation using original resampled parameters.

## Value

A list with following entries

- stat:

  Data frame with statistics

- coef:

  Estimates of derived parameters

- vcov:

  Covariance matrix of derived parameters

- parnames:

  Parameter names

- res_wald:

  Output of Wald test (global test regarding all parameters)

- ...:

  More values

## See also

See also
[`BIFIE.waldtest`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.waldtest.md)
for multi-parameter tests.

See `car::deltaMethod` for the Delta method assuming that the
multivariate distribution of the parameters is asymptotically normal.

## Examples

``` r
#############################################################################
# EXAMPLE 1: Imputed TIMSS dataset
#            Inference for correlations and derived parameters
#############################################################################

data(data.timss1)
data(data.timssrep)

# create BIFIE.dat object
bdat <- BIFIEsurvey::BIFIE.data( data.list=data.timss1, wgt=data.timss1[[1]]$TOTWGT,
           wgtrep=data.timssrep[, -1 ] )
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|

# compute correlations
res1 <- BIFIEsurvey::BIFIE.correl( bdat,
            vars=c("ASSSCI", "ASMMAT", "books", "migrant" )  )
#> |*****|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.correl'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.correl(BIFIEobj = bdat, vars = c("ASSSCI", 
#>     "ASMMAT", "books", "migrant"))
#> 
#> Date of Analysis: 2026-01-08 12:35:50.446265 
#> Time difference of 0.2885253 secs
#> Computation time: 0.2885253 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Statistical Inference for Correlations 
#>     var1    var2 Ncases  Nweight     cor cor_SE      t     df p cor_fmi
#> 2 ASSSCI  ASMMAT   4668 78332.99  0.8292 0.0090  92.62  13.43 0  0.5457
#> 3 ASSSCI   books   4668 78332.99  0.3739 0.0217  17.22 962.93 0  0.0645
#> 4 ASSSCI migrant   4668 78332.99 -0.3402 0.0217 -15.65 354.02 0  0.1063
#> 6 ASMMAT   books   4668 78332.99  0.3379 0.0214  15.78 270.79 0  0.1215
#> 7 ASMMAT migrant   4668 78332.99 -0.2287 0.0237  -9.64 359.64 0  0.1055
#> 9  books migrant   4668 78332.99 -0.2537 0.0209 -12.13    Inf 0  0.0445
#>   cor_VarMI cor_VarRep
#> 2         0     0.0000
#> 3         0     0.0004
#> 4         0     0.0004
#> 6         0     0.0004
#> 7         0     0.0005
#> 9         0     0.0004
#> 
#> Correlation Matrices 
#> 
#> $one1
#>          ASSSCI  ASMMAT   books migrant
#> ASSSCI   1.0000  0.8292  0.3739 -0.3402
#> ASMMAT   0.8292  1.0000  0.3379 -0.2287
#> books    0.3739  0.3379  1.0000 -0.2537
#> migrant -0.3402 -0.2287 -0.2537  1.0000
#> 
res1$parnames
#>  [1] "ASSSCI_ASSSCI"   "ASSSCI_ASMMAT"   "ASSSCI_books"    "ASSSCI_migrant" 
#>  [5] "ASMMAT_ASMMAT"   "ASMMAT_books"    "ASMMAT_migrant"  "books_books"    
#>  [9] "books_migrant"   "migrant_migrant"
  ##    [1] "ASSSCI_ASSSCI"   "ASSSCI_ASMMAT"   "ASSSCI_books"    "ASSSCI_migrant"
  ##    [5] "ASMMAT_ASMMAT"   "ASMMAT_books"    "ASMMAT_migrant"  "books_books"
  ##    [9] "books_migrant"   "migrant_migrant"

# define four derived parameters
derived.parameters <- list(
        # squared correlation of science and mathematics
        "R2_sci_mat"=~ I( 100* ASSSCI_ASMMAT^2  ),
        # partial correlation of science and mathematics controlling for books
        "parcorr_sci_mat"=~ I( ( ASSSCI_ASMMAT - ASSSCI_books * ASMMAT_books ) /
                            sqrt(( 1 - ASSSCI_books^2 ) * ( 1-ASMMAT_books^2 ) ) ),
        # original correlation science and mathematics (already contained in res1)
        "cor_sci_mat"=~ I(ASSSCI_ASMMAT),
        # original correlation books and migrant
        "cor_book_migra"=~ I(books_migrant)
        )

# statistical inference for derived parameters
res2 <- BIFIEsurvey::BIFIE.derivedParameters( res1, derived.parameters )
summary(res2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.derivedParameters'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.derivedParameters(BIFIE.method = res1, derived.parameters = derived.parameters)
#> 
#> Date of Analysis: 2026-01-08 12:35:50.762362 
#> Time difference of 0.03204989 secs
#> Computation time: 0.03204989 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Formulas for Derived Parameters 
#> 
#> R2_sci_mat := I(100 * ASSSCI_ASMMAT^2) 
#> parcorr_sci_mat := I((ASSSCI_ASMMAT - ASSSCI_books * ASMMAT_books)/sqrt((1 - ASSSCI_books^2) * (1 - ASMMAT_books^2))) 
#> cor_sci_mat := I(ASSSCI_ASMMAT) 
#> cor_book_migra := I(books_migrant) 
#> 
#> Statistical Inference for Derived Parameters 
#> 
#>         parmlabel    coef     se        t    df p    fmi  VarMI VarRep
#> 1      R2_sci_mat 68.7673 1.4845  46.3232 13.45 0 0.5453 1.0014 1.0021
#> 2 parcorr_sci_mat  0.8053 0.0092  87.8583 14.40 0 0.5270 0.0000 0.0000
#> 3     cor_sci_mat  0.8292 0.0090  92.6156 13.43 0 0.5457 0.0000 0.0000
#> 4  cor_book_migra -0.2537 0.0209 -12.1266   Inf 0 0.0445 0.0000 0.0004
#> 
#> D1 and D2 Statistic for Wald Test 
#> 
#>         D1     D2 df1 D1_df2 D2_df2 D1_p   D2_p
#> 1 22085063 9.7456   4   38.5    1.7    0 0.1179
```

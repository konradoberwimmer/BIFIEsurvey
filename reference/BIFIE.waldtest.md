# Wald Tests for BIFIE Methods

This function performs a Wald test for objects of classes
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
BIFIE.waldtest(BIFIE.method, Cdes, rdes, type=NULL)

# S3 method for class 'BIFIE.waldtest'
summary(object,digits=4,...)
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

- Cdes:

  Design matrix \\C\\ (see Details)

- rdes:

  Design vector \\r\\ (see Details)

- type:

  Only applies to `BIFIE.correl`. In case of `type="cov"` covariances
  instead of correlations are used for parameter tests.

- object:

  Object of class `BIFIE.waldtest`

- digits:

  Number of digits for rounding output

- ...:

  Further arguments to be passed

## Details

The Wald test is conducted for a parameter vector \\\bold{\theta}\\,
specifying the hypothesis \\C \bold{\theta}=r\\. Statistical inference
is performed by using the \\D_1\\ and the \\D_2\\ statistic (Enders,
2010, Ch. 8).

For objects of class `bifie.univar`, only hypotheses with respect to
means are implemented.

## Value

A list with following entries

- stat.D:

  Data frame with \\D_1\\ and \\D_2\\ statistic, degrees of freedom and
  p value

- ...:

  More values

## References

Enders, C. K. (2010). *Applied missing data analysis*. Guilford Press.

## See also

[`survey::regTermTest`](https://rdrr.io/pkg/survey/man/regTermTest.html),
[`survey::anova.svyglm`](https://rdrr.io/pkg/survey/man/anova.svyglm.html),
`car::linearHypothesis`

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

#******************
#*** Model 1: Linear regression
res1 <- BIFIEsurvey::BIFIE.linreg( bdat, dep="ASMMAT", pre=c("one","books","migrant"),
         group="female" )
#> |*****|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.linreg'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.linreg(BIFIEobj = bdat, dep = "ASMMAT", pre = c("one", 
#>     "books", "migrant"), group = "female")
#> 
#> Date of Analysis: 2026-01-08 12:41:16.125839 
#> Time difference of 0.1284146 secs
#> Computation time: 0.1284146 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Statistical Inference for Linear Regression 
#> 
#>    parameter     var groupvar groupval Ncases  Nweight      est     SE     t
#> 1          b     one   female        0 2388.6 40129.77 475.7590 5.9980 79.32
#> 2          b   books   female        0 2388.6 40129.77  14.7772 1.5953  9.26
#> 3          b migrant   female        0 2388.6 40129.77 -27.5197 4.8707 -5.65
#> 4      sigma      NA   female        0 2388.6 40129.77  59.1117 1.3971 42.31
#> 5        R^2      NA   female        0 2388.6 40129.77   0.1330 0.0225  5.91
#> 6       beta     one   female        0 2388.6 40129.77   0.0000 0.0000   NaN
#> 7       beta   books   female        0 2388.6 40129.77   0.2795 0.0293  9.55
#> 8       beta migrant   female        0 2388.6 40129.77  -0.1716 0.0289 -5.94
#> 9          b     one   female        1 2279.4 38203.22 450.2843 5.7458 78.37
#> 10         b   books   female        1 2279.4 38203.22  19.0498 1.5168 12.56
#> 11         b migrant   female        1 2279.4 38203.22 -19.6951 4.8840 -4.03
#> 12     sigma      NA   female        1 2279.4 38203.22  56.6789 1.2510 45.31
#> 13       R^2      NA   female        1 2279.4 38203.22   0.1506 0.0184  8.18
#> 14      beta     one   female        1 2279.4 38203.22   0.0000 0.0000   NaN
#> 15      beta   books   female        1 2279.4 38203.22   0.3355 0.0249 13.49
#> 16      beta migrant   female        1 2279.4 38203.22  -0.1286 0.0316 -4.07
#>        df      p    fmi  VarMI  VarRep
#> 1  966.02 0.0000 0.0643 1.9292 33.6612
#> 2  244.24 0.0000 0.1280 0.2714  2.2193
#> 3   23.80 0.0000 0.4100 8.1050 13.9980
#> 4  121.92 0.0000 0.1811 0.2946  1.5984
#> 5   55.45 0.0000 0.2686 0.0001  0.0004
#> 6      NA     NA 0.0000 0.0000  0.0000
#> 7  187.64 0.0000 0.1460 0.0001  0.0007
#> 8   24.66 0.0000 0.4028 0.0003  0.0005
#> 9  289.24 0.0000 0.1176 3.2354 29.1319
#> 10 211.92 0.0000 0.1374 0.2634  1.9847
#> 11 118.57 0.0001 0.1837 3.6509 19.4721
#> 12  56.52 0.0000 0.2660 0.3469  1.1486
#> 13 752.75 0.0000 0.0729 0.0000  0.0003
#> 14     NA     NA 0.0000 0.0000  0.0000
#> 15 163.92 0.0000 0.1562 0.0001  0.0005
#> 16 115.40 0.0001 0.1862 0.0002  0.0008

#*** Wald test which tests whether sigma and R^2 values are the same
res1$parnames    # parameter names
#>  [1] "b_one_female_0"        "b_books_female_0"      "b_migrant_female_0"   
#>  [4] "sigma_NA_female_0"     "R^2_NA_female_0"       "beta_one_female_0"    
#>  [7] "beta_books_female_0"   "beta_migrant_female_0" "b_one_female_1"       
#> [10] "b_books_female_1"      "b_migrant_female_1"    "sigma_NA_female_1"    
#> [13] "R^2_NA_female_1"       "beta_one_female_1"     "beta_books_female_1"  
#> [16] "beta_migrant_female_1"
pn <- res1$parnames ; PN <- length(pn)
Cdes <- matrix(0,nrow=2, ncol=PN)
colnames(Cdes) <- pn
# equality of R^2  ( R^2(female0) - R^2(female1)=0 )
Cdes[ 1, c("R^2_NA_female_0", "R^2_NA_female_1" ) ] <- c(1,-1)
# equality of sigma ( sigma(female0) - sigma(female1)=0)
Cdes[ 2, c("sigma_NA_female_0", "sigma_NA_female_1" ) ] <- c(1,-1)
# design vector
rdes <- rep(0,2)
# perform Wald test
wmod1 <- BIFIEsurvey::BIFIE.waldtest( BIFIE.method=res1, Cdes=Cdes, rdes=rdes )
summary(wmod1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.waldtest' for BIFIE method 'BIFIE.linreg'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.waldtest(BIFIE.method = res1, Cdes = Cdes, 
#>     rdes = rdes)
#> 
#> Date of Analysis: 2026-01-08 12:41:16.262466 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> D1 and D2 Statistic for Wald Test 
#> 
#>       D1     D2 df1 D1_df2 D2_df2   D1_p   D2_p
#> 1 0.7432 0.8079   2   13.4   60.5 0.4942 0.4505

if (FALSE) { # \dontrun{
#******************
#*** Model 2: Correlations

# compute some correlations
res2a <- BIFIEsurvey::BIFIE.correl( bdat, vars=c("ASMMAT","ASSSCI","migrant","books"))
summary(res2a)

# test whether r(MAT,migr)=r(SCI,migr) and r(MAT,books)=r(SCI,books)
pn <- res2a$parnames; PN <- length(pn)
Cdes <- matrix( 0, nrow=2, ncol=PN )
colnames(Cdes) <- pn
Cdes[ 1, c("ASMMAT_migrant", "ASSSCI_migrant") ] <- c(1,-1)
Cdes[ 2, c("ASMMAT_books", "ASSSCI_books") ] <- c(1,-1)
rdes <- rep(0,2)
# perform Wald test
wres2a <- BIFIEsurvey::BIFIE.waldtest( res2a, Cdes, rdes )
summary(wres2a)

#******************
#*** Model 3: Frequencies

# Number of books splitted by gender
res3a <- BIFIEsurvey::BIFIE.freq( bdat, vars=c("books"), group="female" )
summary(res3a)

# test whether book(cat4,female0)+book(cat5,female0)=book(cat4,female1)+book(cat5,female5)
pn <- res3a$parnames
PN <- length(pn)
Cdes <- matrix( 0, nrow=1, ncol=PN )
colnames(Cdes) <- pn
Cdes[ 1, c("books_4_female_0", "books_5_female_0",
    "books_4_female_1", "books_5_female_1" ) ] <- c(1,1,-1,-1)
rdes <- c(0)
# Wald test
wres3a <- BIFIEsurvey::BIFIE.waldtest( res3a, Cdes, rdes )
summary(wres3a)

#******************
#*** Model 4: Means

# math and science score splitted by gender
res4a <- BIFIEsurvey::BIFIE.univar( bdat, vars=c("ASMMAT","ASSSCI"), group="female")
summary(res4a)

# test whether there are significant gender differences in math and science
#=> multivariate ANOVA
pn <- res4a$parnames
PN <- length(pn)
Cdes <- matrix( 0, nrow=2, ncol=PN )
colnames(Cdes) <- pn
Cdes[ 1, c("ASMMAT_female_0", "ASMMAT_female_1"  ) ] <- c(1,-1)
Cdes[ 2, c("ASSSCI_female_0", "ASSSCI_female_1"  ) ] <- c(1,-1)
rdes <- rep(0,2)
# Wald test
wres4a <- BIFIEsurvey::BIFIE.waldtest( res4a, Cdes, rdes )
summary(wres4a)
} # }
```

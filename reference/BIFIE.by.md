# Statistics for User Defined Functions

Computes statistics for user defined functions.

## Usage

``` r
BIFIE.by( BIFIEobj, vars, userfct, userparnames=NULL,
     group=NULL, group_values=NULL, se=TRUE, use_Rcpp=TRUE)

# S3 method for class 'BIFIE.by'
summary(object,digits=4,...)

# S3 method for class 'BIFIE.by'
coef(object,...)

# S3 method for class 'BIFIE.by'
vcov(object,...)
```

## Arguments

- BIFIEobj:

  Object of class `BIFIEdata`

- vars:

  Vector of variables for which statistics should be computed

- userfct:

  User defined function. This function must include a matrix `X` and a
  weight vector `w` as arguments. The value of this function must be a
  vector.

- userparnames:

  An optional vector of parameter names for the value of `userfct`.

- group:

  Optional grouping variable(s)

- group_values:

  Optional vector of grouping values. This can be omitted and grouping
  values will be determined automatically.

- se:

  Optional logical indicating whether statistical inference based on
  replication should be employed.

- use_Rcpp:

  Optional logical indicating whether the user defined function should
  be evaluated in Rcpp.

- object:

  Object of class `BIFIE.by`

- digits:

  Number of digits for rounding output

- ...:

  Further arguments to be passed

## Value

A list with following entries

- stat:

  Data frame with statistics defined in `userfct`

- output:

  Extensive output with all replicated statistics

- ...:

  More values

## See also

[`survey::svyby`](https://rdrr.io/pkg/survey/man/svyby.html)

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

#****************************
#*** Model 1: Weighted means (as a toy example)
userfct <- function(X,w){
        pars <- c( stats::weighted.mean( X[,1], w ),
                     stats::weighted.mean(X[,2], w )   )
        return(pars)
                        }
res1 <-  BIFIEsurvey::BIFIE.by( bifieobj, vars=c("ASMMAT", "migrant", "books"),
                userfct=userfct, userparnames=c("MW_MAT", "MW_Migr"),
                group="female" )
#> |*****|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.by'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.by(BIFIEobj = bifieobj, vars = c("ASMMAT", 
#>     "migrant", "books"), userfct = userfct, userparnames = c("MW_MAT", 
#>     "MW_Migr"), group = "female")
#> 
#> Date of Analysis: 2026-01-08 12:35:27.52978 
#> Time difference of 0.272506 secs
#> Computation time: 0.272506 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Statistical Inference for User Defined Function 
#>      parm groupvar groupval Ncases  Nweight      est     SE      t     df p
#> 1  MW_MAT   female        0 2388.6 40129.77 512.8511 3.2557 157.53    Inf 0
#> 2 MW_Migr   female        0 2388.6 40129.77   0.1947 0.0144  13.53    Inf 0
#> 3  MW_MAT   female        1 2279.4 38203.22 503.5417 2.6049 193.31 454.07 0
#> 4 MW_Migr   female        1 2279.4 38203.22   0.2021 0.0137  14.78    Inf 0
#>      fmi  VarMI  VarRep
#> 1 0.0279 0.2468 10.3031
#> 2 0.0064 0.0000  0.0002
#> 3 0.0939 0.5307  6.1486
#> 4 0.0148 0.0000  0.0002

# evaluate function in pure R implementation using the use_Rcpp argument
res1b <-  BIFIEsurvey::BIFIE.by( bifieobj, vars=c("ASMMAT", "migrant", "books" ),
                userfct=userfct, userparnames=c("MW_MAT", "MW_Migr"),
                group="female", use_Rcpp=FALSE )
#> |*****|
#> |-----|
summary(res1b)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.by'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.by(BIFIEobj = bifieobj, vars = c("ASMMAT", 
#>     "migrant", "books"), userfct = userfct, userparnames = c("MW_MAT", 
#>     "MW_Migr"), group = "female", use_Rcpp = FALSE)
#> 
#> Date of Analysis: 2026-01-08 12:35:27.808019 
#> Time difference of 0.2341361 secs
#> Computation time: 0.2341361 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Statistical Inference for User Defined Function 
#>      parm groupvar groupval Ncases  Nweight      est     SE      t     df p
#> 1  MW_MAT   female        0 2388.6 40129.77 512.8511 3.2557 157.53    Inf 0
#> 2 MW_Migr   female        0 2388.6 40129.77   0.1947 0.0144  13.53    Inf 0
#> 3  MW_MAT   female        1 2279.4 38203.22 503.5417 2.6049 193.31 454.07 0
#> 4 MW_Migr   female        1 2279.4 38203.22   0.2021 0.0137  14.78    Inf 0
#>      fmi  VarMI  VarRep
#> 1 0.0279 0.2468 10.3031
#> 2 0.0064 0.0000  0.0002
#> 3 0.0939 0.5307  6.1486
#> 4 0.0148 0.0000  0.0002

#--- statistical inference for a derived parameter (see ?BIFIE.derivedParameters)
# define gender difference for mathematics score (divided by 100)
derived.parameters <- list(
        "gender_diff"=~ 0 + I( ( MW_MAT_female1 - MW_MAT_female0 ) / 100 )
                            )
# inference derived parameter
res1d <- BIFIEsurvey::BIFIE.derivedParameters( res1,
                derived.parameters=derived.parameters )
summary(res1d)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.derivedParameters'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.derivedParameters(BIFIE.method = res1, derived.parameters = derived.parameters)
#> 
#> Date of Analysis: 2026-01-08 12:35:28.047379 
#> Time difference of 0.002600908 secs
#> Computation time: 0.002600908 
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
#> gender_diff := I((MW_MAT_female1 - MW_MAT_female0)/100) 
#> 
#> Statistical Inference for Derived Parameters 
#> 
#>     parmlabel    coef     se       t    df      p    fmi VarMI VarRep
#> 1 gender_diff -0.0931 0.0258 -3.6066 740.8 0.0003 0.0735     0 0.0006
#> 
#> D1 and D2 Statistic for Wald Test 
#> 
#>        D1    D2 df1 D1_df2 D2_df2   D1_p  D2_p
#> 1 13.0073 11.37   1      4  105.3 0.0226 0.001

if (FALSE) { # \dontrun{
#****************************
#**** Model 2: Robust linear model

# (1) start from scratch to formulate the user function for X and w
dat1 <- bifieobj$dat1
vars <- c("ASMMAT", "migrant", "books" )
X <- dat1[,vars]
w <- bifieobj$wgt
library(MASS)
# ASMMAT ~ migrant + books
mod <- MASS::rlm( X[,1] ~  as.matrix( X[, -1 ] ), weights=w )
coef(mod)
# (2) define a user function "my_rlm"
my_rlm <- function(X,w){
    mod <- MASS::rlm( X[,1] ~  as.matrix( X[, -1 ] ), weights=w )
    return( coef(mod) )
                }
# (3) estimate model
res2 <-  BIFIEsurvey::BIFIE.by( bifieobj, vars, userfct=my_rlm,
                group="female", group_values=0:1)
summary(res2)
# estimate model without computing standard errors
res2a <-  BIFIEsurvey::BIFIE.by( bifieobj, vars, userfct=my_rlm,
                group="female", se=FALSE)
summary(res2a)

# define a user function with formula language
my_rlm2 <- function(X,w){
    colnames(X) <- vars
    X <- as.data.frame(X)
    mod <- MASS::rlm( ASMMAT ~  migrant + books, weights=w, data=X)
    return( coef(mod) )
                }
# estimate model
res2b <-  BIFIEsurvey::BIFIE.by( bifieobj, vars, userfct=my_rlm2,
                group="female", group_values=0:1)
summary(res2b)


#****************************
#**** Model 3: Number of unique values for variables in BIFIEdata

#*** define variables for which the number of unique values should be calculated
vars <- c( "female", "books","ASMMAT" )
#*** define a user function extracting these unqiue values
userfct <- function(X,w){
        pars <- apply( X, 2, FUN=function(vv){
                     length( unique(vv))  } )
        # Note that weights are (of course) ignored in this function
        return(pars)
                        }
#*** extract number of unique values
res3 <-  BIFIEsurvey::BIFIE.by( bifieobj, vars=vars, userfct=userfct,
              userparnames=paste0( vars, "_Nunique"),  se=FALSE )
summary(res3)
  ##   Statistical Inference for User Definition Function
  ##               parm Ncases  Nweight    est
  ##   1 female_Nunique   4668 78332.99    2.0
  ##   2  books_Nunique   4668 78332.99    5.0
  ##   3 ASMMAT_Nunique   4668 78332.99 4613.4
# number of unique values in each of the five imputed datasets
res3$output$parsrepM
  ##        [,1] [,2] [,3] [,4] [,5]
  ##   [1,]    2    2    2    2    2
  ##   [2,]    5    5    5    5    5
  ##   [3,] 4617 4619 4614 4609 4608

#****************************
#**** Model 4: Estimation of a lavaan model with BIFIE.by

#* estimate model in lavaan

data0 <- data.timss1[[1]]
# define lavaan model
lavmodel <- "
  ASSSCI ~ likesc
  ASSSCI ~~ ASSSCI
  likesc ~ female
  likesc ~~ likesc
  female ~~ female
"

mod0 <- lavaan::lavaan(lavmodel, data=data0, sampling.weights="TOTWGT")
summary(mod0, stand=TRUE, fit.measures=TRUE)

#* construct input for BIFIE.by
vars <- c("ASSSCI","likesc","female","TOTWGT")
X <- data0[,vars]
mod0 <- lavaan::lavaan(lavmodel, data=X, sampling.weights="TOTWGT")
w <- data0$TOTWGT

#* define user function
userfct <- function(X,w){
  X1 <- as.data.frame(X)
  colnames(X1) <- vars
  X1$studwgt <- w
  mod0 <- lavaan::lavaan(lavmodel, data=X1, sampling.weights="TOTWGT")
  pars <- coef(mod0)
  # extract some fit statistics
  pars2 <- lavaan::fitMeasures(mod0)
  pars <- c(pars, pars2[c("cfi","tli")])
  return(pars)
}

#* test function
res0 <- userfct(X,w)
userparnames <- names(res0)

#* estimate lavaan model with replicated sampling weights
res1 <-  BIFIEsurvey::BIFIE.by( bifieobj, vars=vars, userfct=userfct,
                  userparnames=userparnames, use_Rcpp=FALSE )
summary(res1)
} # }
```

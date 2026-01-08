# Logistic Regression

Computes logistic regression. Explained variance \\R^2\\ is computed by
the approach of McKelvey and Zavoina.

## Usage

``` r
BIFIE.logistreg(BIFIEobj, dep=NULL, pre=NULL, formula=NULL,
    group=NULL, group_values=NULL, se=TRUE, eps=1E-8, maxiter=100)

# S3 method for class 'BIFIE.logistreg'
summary(object,digits=4,...)

# S3 method for class 'BIFIE.logistreg'
coef(object,...)

# S3 method for class 'BIFIE.logistreg'
vcov(object,...)
```

## Arguments

- BIFIEobj:

  Object of class `BIFIEdata`

- dep:

  String for the dependent variable in the regression model

- pre:

  Vector of predictor variables. If the intercept should be included,
  then use the variable `one` for specifying it (see Examples).

- formula:

  An R formula object which can be applied instead of providing `dep`
  and `pre`. Note that there is additional computation time needed for
  model matrix creation.

- group:

  Optional grouping variable(s)

- group_values:

  Optional vector of grouping values. This can be omitted and grouping
  values will be determined automatically.

- se:

  Optional logical indicating whether statistical inference based on
  replication should be employed.

- eps:

  Convergence criterion for parameters

- maxiter:

  Maximum number of iterations

- object:

  Object of class `BIFIE.logistreg`

- digits:

  Number of digits for rounding output

- ...:

  Further arguments to be passed

## Value

A list with following entries

- stat:

  Data frame with regression coefficients

- output:

  Extensive output with all replicated statistics

- ...:

  More values

## See also

[`survey::svyglm`](https://rdrr.io/pkg/survey/man/svyglm.html),
[`stats::glm`](https://rdrr.io/r/stats/glm.html)

For linear regressions see
[`BIFIE.linreg`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.linreg.md).

## Examples

``` r
#############################################################################
# EXAMPLE 1: TIMSS dataset | Logistic regression
#############################################################################

data(data.timss2)
data(data.timssrep)

# create BIFIE.dat object
bdat <- BIFIEsurvey::BIFIE.data( data.list=data.timss2, wgt=data.timss2[[1]]$TOTWGT,
                      wgtrep=data.timssrep[, -1 ] )
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|

#**** Model 1: Logistic regression - prediction of migrational background
res1 <- BIFIEsurvey::BIFIE.logistreg( BIFIEobj=bdat, dep="migrant",
           pre=c("one","books","lang"), group="female", se=FALSE )
#> |*****|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.logistreg'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.logistreg(BIFIEobj = bdat, dep = "migrant", 
#>     pre = c("one", "books", "lang"), group = "female", se = FALSE)
#> 
#> Date of Analysis: 2026-01-08 12:41:13.013916 
#> Time difference of 0.01161337 secs
#> Computation time: 0.01161337 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 0 
#> Fay factor = 1 
#> 
#> Statistical Inference for Logistic Regression 
#>   parameter   var groupvar groupval Ncases  Nweight     est    fmi VarMI
#> 1         b   one   female        0   2206 37278.92 -3.4079 0.0000     0
#> 2         b books   female        0   2206 37278.92 -0.6214 0.0000     0
#> 3         b  lang   female        0   2206 37278.92  2.5188 0.0000     0
#> 4        R2    NA   female        0   2206 37278.92  0.4568 0.0000     0
#> 5         b   one   female        1   2138 35821.63 -3.8701 0.9969     0
#> 6         b books   female        1   2138 35821.63 -0.4872 0.0000     0
#> 7         b  lang   female        1   2138 35821.63  2.7094 0.0000     0
#> 8        R2    NA   female        1   2138 35821.63  0.4363 0.0000     0

if (FALSE) { # \dontrun{
# same model, but with formula specification and standard errors
res1a <- BIFIEsurvey::BIFIE.logistreg( BIFIEobj=bdat,
              formula=migrant ~ books + lang, group="female"  )
summary(res1a)

#############################################################################
# SIMULATED EXAMPLE 2: Comparison of stats::glm and BIFIEsurvey::BIFIE.logistreg
#############################################################################

#*** (1) simulate data
set.seed(987)
N <- 300
x1 <- stats::rnorm(N)
x2 <- stats::runif(N)
ypred <- -0.75+.2*x1 + 3*x2
y <- 1*( stats::plogis(ypred) > stats::runif(N) )
data <- data.frame( "y"=y, "x1"=x1, "x2"=x2 )

#*** (2) estimation logistic regression using glm
mod1 <- stats::glm( y ~ x1 + x2, family="binomial")

#*** (3) estimation logistic regression using BIFIEdata
# create BIFIEdata object by defining 30 Jackknife zones
bifiedata <- BIFIEsurvey::BIFIE.data.jack( data, jktype="JK_RANDOM", ngr=30 )
summary(bifiedata)
# estimate logistic regression
mod2 <- BIFIEsurvey::BIFIE.logistreg( bifiedata, formula=y ~ x1+x2 )

#*** (4) compare results
summary(mod2)    # BIFIE.logistreg
summary(mod1)   # glm
} # }
```

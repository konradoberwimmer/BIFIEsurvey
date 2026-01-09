# Linear Regression

Computes linear regression.

## Usage

``` r
BIFIE.linreg(BIFIEobj, dep=NULL, pre=NULL, formula=NULL,
    group=NULL, group_values=NULL, se=TRUE)

# S3 method for class 'BIFIE.linreg'
summary(object,digits=4,...)

# S3 method for class 'BIFIE.linreg'
coef(object,...)

# S3 method for class 'BIFIE.linreg'
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

- object:

  Object of class `BIFIE.linreg`

- digits:

  Number of digits for rounding output

- ...:

  Further arguments to be passed

## Value

A list with following entries

- stat:

  Data frame with unstandardized and standardized regression
  coefficients, residual standard deviation and \\R^2\\

- output:

  Extensive output with all replicated statistics

- ...:

  More values

## See also

Alternative implementations:
[`survey::svyglm`](https://rdrr.io/pkg/survey/man/svyglm.html),
[`intsvy::timss.reg`](https://rdrr.io/pkg/intsvy/man/timss.reg.html),
[`intsvy::timss.reg.pv`](https://rdrr.io/pkg/intsvy/man/timss.reg.pv.html),
[`stats::lm`](https://rdrr.io/r/stats/lm.html)

See
[`BIFIE.logistreg`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.logistreg.md)
for logistic regression.

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

#**** Model 1: Linear regression for mathematics score
mod1 <- BIFIEsurvey::BIFIE.linreg( bdat, dep="ASMMAT", pre=c("one","books","migrant"),
              group="female" )
#> |*****|
#> |-----|
summary(mod1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.linreg'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.linreg(BIFIEobj = bdat, dep = "ASMMAT", pre = c("one", 
#>     "books", "migrant"), group = "female")
#> 
#> Date of Analysis: 2026-01-09 04:20:12.73961 
#> Time difference of 0.1279342 secs
#> Computation time: 0.1279342 
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

if (FALSE) { # \dontrun{
# same model but specified with R formulas
mod1a <- BIFIEsurvey::BIFIE.linreg( bdat, formula=ASMMAT ~ books + migrant,
               group="female", group_values=0:1 )
summary(mod1a)

# compare result with lm function and first imputed dataset
dat1 <- data.timss1[[1]]
mod1b <- stats::lm( ASMMAT ~ 0 + as.factor(female) + as.factor(female):books +
                              as.factor(female):migrant,
                         data=dat1,  weights=dat1$TOTWGT )
summary(mod1b)

#**** Model 2: Like Model 1, but books is now treated as a factor
mod2 <- BIFIEsurvey::BIFIE.linreg( bdat, formula=ASMMAT ~ as.factor(books) + migrant)
summary(mod2)

#############################################################################
# EXAMPLE 2: PISA data | Nonlinear regression models
#############################################################################

data(data.pisaNLD)
data <- data.pisaNLD

#--- Create BIFIEdata object immediately using BIFIE.data.jack function
bdat <- BIFIEsurvey::BIFIE.data.jack( data.pisaNLD, jktype="RW_PISA", cdata=TRUE)
summary(bdat)

#****************************************************
#*** Model 1: linear regression
mod1 <- BIFIEsurvey::BIFIE.linreg( bdat, formula=MATH ~ HISEI )
summary(mod1)

#****************************************************
#*** Model 2: Cubic regression
mod2 <- BIFIEsurvey::BIFIE.linreg( bdat, formula=MATH ~ HISEI + I(HISEI^2) + I(HISEI^3) )
summary(mod2)

#****************************************************
#*** Model 3: B-spline regression

# test with design of HISEI values
dfr <- data.frame("HISEI"=16:90 )
des <- stats::model.frame( ~ splines::bs( HISEI, df=5 ), dfr )
des <- des$splines
plot( dfr$HISEI, des[,1], type="l", pch=1, lwd=2, ylim=c(0,1) )
for (vv in 2:ncol(des) ){
    lines( dfr$HISEI, des[,vv], lty=vv, col=vv, lwd=2)
}

# apply B-spline regression in BIFIEsurvey::BIFIE.linreg
mod3 <- BIFIEsurvey::BIFIE.linreg( bdat, formula=MATH ~ splines::bs(HISEI,df=5) )
summary(mod3)

#*** include transformed HISEI values for B-spline matrix in bdat
bdat2 <- BIFIEsurvey::BIFIE.data.transform( bdat, ~ 0 + splines::bs( HISEI, df=5 ))
bdat2$varnames[ bdat2$varsindex.added ] <- paste0("HISEI_bsdes",
            seq( 1, length( bdat2$varsindex.added ) ) )

#****************************************************
#*** Model 4: Nonparametric regression using BIFIE.by

?BIFIE.by

#---- (1) test function with one dataset
dat1 <- bdat$dat1
vars <- c("MATH", "HISEI")
X <- dat1[,vars]
w <- bdat$wgt
X <- as.data.frame(X)
# estimate model
mod <- stats::loess( MATH ~ HISEI, weights=w, data=X )

# predict HISEI values
hisei_val <- data.frame( "HISEI"=seq(16,90) )
y_pred <- stats::predict( mod, hisei_val )
graphics::plot( hisei_val$HISEI, y_pred, type="l")

#--- (2) define loess function
loess_fct <- function(X,w){
    X1 <- data.frame( X, w )
    colnames(X1) <- c( vars, "wgt")
    X1 <- stats::na.omit(X1)
#    mod <- stats::lm( MATH ~ HISEI, weights=X1$wgt, data=X1 )
    mod <- stats::loess( MATH ~ HISEI, weights=X1$wgt, data=X1 )
    y_pred <- stats::predict( mod, hisei_val )
    return(y_pred)
}

#--- (3) estimate model
mod4 <-  BIFIEsurvey::BIFIE.by( bdat, vars, userfct=loess_fct )
summary(mod4)

# plot linear function pointwise and confidence intervals
graphics::plot( hisei_val$HISEI, mod4$stat$est, type="l", lwd=2,
        xlab="HISEI", ylab="PVMATH", ylim=c(430,670) )
graphics::lines( hisei_val$HISEI, mod4$stat$est - 1.96* mod4$stat$SE, lty=3 )
graphics::lines( hisei_val$HISEI, mod4$stat$est + 1.96* mod4$stat$SE, lty=3 )
} # }
```

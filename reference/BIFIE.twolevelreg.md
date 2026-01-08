# Two Level Regression

This function computes the hierarchical two level model with random
intercepts and random slopes. The full maximum likelihood estimation is
conducted by means of an EM algorithm (Raudenbush & Bryk, 2002).

## Usage

``` r
BIFIE.twolevelreg( BIFIEobj, dep, formula.fixed, formula.random, idcluster,
   wgtlevel2=NULL, wgtlevel1=NULL, group=NULL, group_values=NULL,
   recov_constraint=NULL, se=TRUE, globconv=1E-6, maxiter=1000 )

# S3 method for class 'BIFIE.twolevelreg'
summary(object,digits=4,...)

# S3 method for class 'BIFIE.twolevelreg'
coef(object,...)

# S3 method for class 'BIFIE.twolevelreg'
vcov(object,...)
```

## Arguments

- BIFIEobj:

  Object of class `BIFIEdata`

- dep:

  String for the dependent variable in the regression model

- formula.fixed:

  An R formula for fixed effects

- formula.random:

  An R formula for random effects

- idcluster:

  Cluster identifier. The cluster identifiers must be sorted in the
  `BIFIE.data` object.

- wgtlevel2:

  Name of Level 2 weight variable

- wgtlevel1:

  Name of Level 1 weight variable. This is optional. If it is not
  provided, `wgtlevel` is calculated from the total weight and
  `wgtlevel2`.

- group:

  Optional grouping variable

- group_values:

  Optional vector of grouping values. This can be omitted and grouping
  values will be determined automatically.

- recov_constraint:

  Matrix for constraints of random effects covariance matrix. The random
  effects are numbered according to the order in the specification in
  `formula.random`. The first column in `recov_constraint` contains the
  row index in the covariance matrix, the second column the column index
  and the third column the value to be fixed.

- se:

  Optional logical indicating whether statistical inference based on
  replication should be employed. In case of `se=FALSE`, standard errors
  are computed as maximum likelihood estimates under the assumption of
  random sampling of level 2 clusters.

- globconv:

  Convergence criterion for maximum parameter change

- maxiter:

  Maximum number of iterations

- object:

  Object of class `BIFIE.twolevelreg`

- digits:

  Number of digits for rounding output

- ...:

  Further arguments to be passed

## Details

The implemented random slope model can be written as
\$\$y\_{ij}=\bold{X}\_{ij} \bold{\gamma} + \bold{Z}\_{ij} \bold{u}\_j +
\varepsilon\_{ij}\$\$ where \\y\_{ij}\\ is the dependent variable,
\\\bold{X}\_{ij}\\ includes the fixed effects predictors (specified by
`formula.fixed`) and \\\bold{Z}\_{ij}\\ includes the random effects
predictors (specified by `formula.random`). The random effects
\\\bold{u}\_j\\ follow a multivariate normal distribution.

The function also computes a variance decomposition of explained
variance due to fixed and random effects for the within and the between
level. This variance decomposition is conducted for the predictor
matrices \\\bold{X}\\ and \\\bold{Z}\\. It is assumed that \\
\bold{X}\_{ij}=\bold{X}\_j^B + \bold{X}\_{ij}^W\\. The different sources
of variance are computed by formulas as proposed in Snijders and Bosker
(2012, Ch. 7).

## Value

A list with following entries

- stat:

  Data frame with coefficients and different sources of variance.

- output:

  Extensive output with all replicated statistics

- ...:

  More values

## References

Raudenbush, S. W., & Bryk, A. S. (2002). *Hierarchical linear models:
Applications and data analysis methods*. Thousand Oaks: Sage.

Snijders, T. A. B., & Bosker, R. J. (2012). *Multilevel analysis: An
introduction to basic and advanced multilevel modeling*. Thousand Oaks:
Sage.

## See also

The [`lme4::lmer`](https://rdrr.io/pkg/lme4/man/lmer.html) function in
the lme4 package allows only weights at the first level.

See the WeMix package (and the function `WeMix::mix`) for estimation of
mixed effects models with weights at different levels.

## Examples

``` r
if (FALSE) { # \dontrun{
library(lme4)

#############################################################################
# EXAMPLE 1: Dataset data.bifie01 | TIMSS 2011
#############################################################################

data(data.bifie01)
dat <- data.bifie01
set.seed(987)

# create dataset with replicate weights and plausible values
bdat1 <- BIFIEsurvey::BIFIE.data.jack( data=dat, jktype="JK_TIMSS", jkzone="JKCZONE",
            jkrep="JKCREP", wgt="TOTWGT", pv_vars=c("ASMMAT","ASSSCI") )

# create dataset without plausible values and ignoring weights
bdat2 <- BIFIEsurvey::BIFIE.data.jack( data=dat, jktype="JK_RANDOM", ngr=10 )
#=> standard errors from ML estimation

#***********************************************
# Model 1: Random intercept model

#--- Model 1a: without weights, first plausible value
mod1a <- BIFIEsurvey::BIFIE.twolevelreg( BIFIEobj=bdat2, dep="ASMMAT01",
                formula.fixed=~ 1, formula.random=~ 1, idcluster="idschool",
                wgtlevel2="one", se=FALSE )
summary(mod1a)

#--- Model 1b: estimation in lme4
mod1b <- lme4::lmer( ASMMAT01 ~ 1 + ( 1 | idschool), data=dat, REML=FALSE)
summary(mod1b)

#--- Model 1c: Like Model 1a but for five plausible values and ML inference
mod1c <- BIFIEsurvey::BIFIE.twolevelreg( BIFIEobj=bdat1, dep="ASMMAT",
                formula.fixed=~ 1, formula.random=~ 1, idcluster="idschool",
                wgtlevel2="one",  se=FALSE )
summary(mod1c)

#--- Model 1d: weights and sampling design and all plausible values
mod1d <- BIFIEsurvey::BIFIE.twolevelreg( BIFIEobj=bdat1, dep="ASMMAT",
                formula.fixed=~ 1, formula.random=~ 1, idcluster="idschool",
                wgtlevel2="SCHWGT" )
summary(mod1d)

#***********************************************
# Model 2: Random slope model

#--- Model 2a: without weights
mod2a <- BIFIEsurvey::BIFIE.twolevelreg( BIFIEobj=bdat2, dep="ASMMAT01",
                formula.fixed=~  female +  ASBG06A, formula.random=~ ASBG06A,
                idcluster="idschool", wgtlevel2="one",  se=FALSE )
summary(mod2a)

#--- Model 2b: estimation in lme4
mod2b <- lme4::lmer( ASMMAT01 ~ female +  ASBG06A + ( 1 + ASBG06A | idschool),
                   data=dat, REML=FALSE)
summary(mod2b)

#--- Model 2c: weights and sampling design and all plausible values
mod2c <- BIFIEsurvey::BIFIE.twolevelreg( BIFIEobj=bdat1, dep="ASMMAT",
                formula.fixed=~  female +  ASBG06A, formula.random=~ ASBG06A,
                idcluster="idschool", wgtlevel2="SCHWGT", maxiter=500, se=FALSE)
summary(mod2c)

#--- Model 2d: Uncorrelated intecepts and slopes

# constraint for zero covariance between intercept and slope
recov_constraint <- matrix( c(1,2,0), ncol=3 )
mod2d <- BIFIEsurvey::BIFIE.twolevelreg( BIFIEobj=bdat2, dep="ASMMAT01",
                formula.fixed=~ female +  ASBG06A, formula.random=~ ASBG06A,
                idcluster="idschool", wgtlevel2="one",  se=FALSE,
                recov_constraint=recov_constraint )
summary(mod2d)

#--- Model 2e: Fixed entries in the random effects covariance matrix

# two constraints for random effects covariance
# Cov(Int, Slo)=0  # zero slope for intercept and slope
# Var(Slo)=10      # slope variance of 10
recov_constraint <- matrix( c(1,2,0,
                      2,2,10), ncol=3, byrow=TRUE)
mod2e <- BIFIEsurvey::BIFIE.twolevelreg( BIFIEobj=bdat2, dep="ASMMAT01",
                formula.fixed=~  female +  ASBG06A, formula.random=~ ASBG06A,
                idcluster="idschool", wgtlevel2="one",  se=FALSE,
                recov_constraint=recov_constraint )
summary(mod2e)

#############################################################################
# SIMULATED EXAMPLE 2: Two-level regression with random slopes
#############################################################################

#--- (1) simulate data
set.seed(9876)
NC <- 100    # number of clusters
Nj <- 20     # number of persons per cluster
iccx <- .4   # intra-class correlation predictor
theta <- c( 0.7, .3 )    # fixed effects
Tmat <- diag( c(.3, .1 ) ) # variances of random intercept and slope
sig2 <- .60    # residual variance
N <- NC*Nj
idcluster <- rep( 1:NC, each=Nj )
dat1 <- data.frame("idcluster"=idcluster )
dat1$X <- rep( stats::rnorm( NC, sd=sqrt(iccx) ), each=Nj ) +
                 stats::rnorm( N, sd=sqrt( 1 - iccx) )
dat1$Y <- theta[1] + rep( stats::rnorm(NC, sd=sqrt(Tmat[1,1] ) ), each=Nj ) +
      theta[2] + rep( stats::rnorm(NC, sd=sqrt(Tmat[2,2])), each=Nj ) * dat1$X +
      stats::rnorm(N, sd=sqrt(sig2) )

#--- (2) create design object
bdat1 <- BIFIEsurvey::BIFIE.data.jack( data=dat1, jktype="JK_GROUP", jkzone="idcluster")
summary(bdat1)

#*** Model 1: Random slope model (ML standard errors)

#- estimation using BIFIE.twolevelreg
mod1a <- BIFIEsurvey::BIFIE.twolevelreg( BIFIEobj=bdat1, dep="Y",
                formula.fixed=~ 1+X, formula.random=~ 1+X, idcluster="idcluster",
                wgtlevel2="one",  se=FALSE )
summary(mod1a)

#- estimation in lme4
mod1b <- lme4::lmer( Y ~ X + ( 1+X | idcluster), data=dat1, REML=FALSE  )
summary(mod1b)

#- using Jackknife for inference
mod1c <- BIFIEsurvey::BIFIE.twolevelreg( BIFIEobj=bdat1, dep="Y",
                formula.fixed=~ 1+X, formula.random=~ 1+X, idcluster="idcluster",
                wgtlevel2="one",  se=TRUE )
summary(mod1c)

# extract coefficients
coef(mod1a)
coef(mod1c)
# covariance matrix
vcov(mod1a)
vcov(mod1c)
} # }
```

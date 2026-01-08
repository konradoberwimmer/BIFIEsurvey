# Path Model Estimation

This function computes a path model. Predictors are allowed to possess
measurement errors. Known measurement error variances (and covariances)
or reliabilities can be specified by the user. Alternatively, a set of
indicators can be defined for each latent variable, and for each imputed
and replicated dataset the measurement error variance is determined by
means of calculating the reliability Cronbachs alpha. Measurement errors
are handled by adjusting covariance matrices (see Buonaccorsi, 2010, Ch.
5).

## Usage

``` r
BIFIE.pathmodel( BIFIEobj, lavaan.model, reliability=NULL, group=NULL,
        group_values=NULL, se=TRUE )

# S3 method for class 'BIFIE.pathmodel'
summary(object,digits=4,...)

# S3 method for class 'BIFIE.pathmodel'
coef(object,...)

# S3 method for class 'BIFIE.pathmodel'
vcov(object,...)
```

## Arguments

- BIFIEobj:

  Object of class `BIFIEdata`

- lavaan.model:

  String including the model specification in lavaan syntax.
  `lavaan.model` also allows the extended functionality in the
  [`TAM::lavaanify.IRT`](https://rdrr.io/pkg/TAM/man/lavaanify.IRT.html)
  function.

- reliability:

  Optional vector containing the reliabilities of each variable. This
  vector can also include only a subset of all variables.

- group:

  Optional grouping variable(s)

- group_values:

  Optional vector of grouping values. This can be omitted and grouping
  values will be determined automatically.

- se:

  Optional logical indicating whether statistical inference based on
  replication should be employed.

- object:

  Object of class `BIFIE.pathmodel`

- digits:

  Number of digits for rounding output

- ...:

  Further arguments to be passed

## Details

The following conventions are used as parameter labels in the output.

`Y~X` is the regression coefficient of the regression from \\Y\\ on
\\X\\.

`X->Z->Y` denotes the path coefficient from \\X\\ to \\Y\\ passing the
mediating variable \\Z\\.

`X-+>Y` denotes the total effect (of all paths) from \\X\\ to \\Y\\.

`X-~>Y` denotes the sum of all indirect effects from \\X\\ to \\Y\\.

The parameter suffix `_stand` refers to parameters for which all
variables are standardized.

## Value

A list with following entries

- stat:

  Data frame with unstandardized and standardized regression
  coefficients, path coefficients, total and indirect effects, residual
  variances, and \\R^2\\

- output:

  Extensive output with all replicated statistics

- ...:

  More values

## References

Buonaccorsi, J. P. (2010). *Measurement error: Models, methods, and
applications*. CRC Press.

## See also

See the lavaan and **lavaan.survey** package.

For the `lavaan` syntax, see
[`lavaan::lavaanify`](https://rdrr.io/pkg/lavaan/man/model.syntax.html)
and
[`TAM::lavaanify.IRT`](https://rdrr.io/pkg/TAM/man/lavaanify.IRT.html)

## Examples

``` r
if (FALSE) { # \dontrun{
#############################################################################
# EXAMPLE 1: Path model data.bifie01
#############################################################################

data(data.bifie01)
dat <- data.bifie01
# create dataset with replicate weights and plausible values
bifieobj <- BIFIEsurvey::BIFIE.data.jack( data=dat,  jktype="JK_TIMSS",
                jkzone="JKCZONE", jkrep="JKCREP", wgt="TOTWGT",
                pv_vars=c("ASMMAT","ASSSCI") )

#**************************************************************
#*** Model 1: Path model
lavmodel1 <- "
     ASMMAT ~ ASBG07A + ASBG07B  + ASBM03 + ASBM02A + ASBM02E
     # define latent variable with 2nd and 3rd item in reversed scoring
     ASBM03=~ 1*ASBM03A + (-1)*ASBM03B + (-1)*ASBM03C + 1*ASBM03D
     ASBG07A ~ ASBM02E
     ASBG07A ~~ .2*ASBG07A    # measurement error variance of .20
     ASBM02E ~~ .45*ASBM02E     # measurement error variance of .45
     ASBM02E ~ ASBM02A + ASBM02B
        "
#--- Model 1a: model calculated by gender
mod1a <- BIFIEsurvey::BIFIE.pathmodel( bifieobj, lavmodel1, group="female" )
summary(mod1a)

#--- Model 1b: Input of some known reliabilities
reliability <- c( "ASBM02B"=.6, "ASBM02A"=.8 )
mod1b <- BIFIEsurvey::BIFIE.pathmodel( bifieobj, lavmodel1, reliability=reliability)
summary(mod1b)

#**************************************************************
#*** Model 2: Linear regression with errors in predictors

# specify lavaan model
lavmodel2 <- "
     ASMMAT ~ ASBG07A + ASBG07B + ASBM03A
     ASBG07A ~~ .2*ASBG07A
        "
mod2 <- BIFIEsurvey::BIFIE.pathmodel( bifieobj, lavmodel2  )
summary(mod2)
} # }
```

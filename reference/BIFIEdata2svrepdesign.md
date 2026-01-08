# Conversion of a `BIFIEdata` Object into a `svyrep` Object in the survey Package (and the other way around)

The function `BIFIEdata2svrepdesign` converts of a `BIFIEdata` object
into a `svyrep` object in the survey package.

The function `svrepdesign2BIFIEdata` converts a `svyrep` object in the
survey package into an object of class `BIFIEdata`.

## Usage

``` r
BIFIEdata2svrepdesign(bifieobj, varnames=NULL, impdata.index=NULL)

svrepdesign2BIFIEdata(svrepdesign, varnames=NULL, cdata=FALSE)
```

## Arguments

- bifieobj:

  Object of class `BIFIEdata`

- varnames:

  Optional vector with variable names

- impdata.index:

  Selected indices of imputed datasets

- svrepdesign:

  Object of class `svyrep.design` or `svyimputationList`

- cdata:

  Logical inducating whether `BIFIEdata` object should be saved in
  compact format

## Value

Function `BIFIEdata2svrepdesign`: Object of class `svyrep.design` or
`svyimputationList`  

Function `svrepdesign2BIFIEdata`: Object of class `BIFIEdata`

## See also

See the
[`BIFIE.data`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.md)
function for creating objects of class `BIFIEdata` in BIFIEsurvey.

See the
[`survey::svrepdesign`](https://rdrr.io/pkg/survey/man/svrepdesign.html)
function in the survey package.

## Examples

``` r
if (FALSE) { # \dontrun{
#############################################################################
# EXAMPLE 1: One dataset, TIMSS replication design
#############################################################################

data(data.timss3)
data(data.timssrep)

#--- create BIFIEdata object
bdat3 <- BIFIEsurvey::BIFIE.data.jack(data.timss3, jktype="JK_TIMSS")
summary(bdat3)

#--- create survey object directly in survey package
dat3a <- as.data.frame( cbind( data.timss3, data.timssrep ) )
RR <- ncol(data.timssrep) - 1       # number of jackknife zones
svydes3a <- survey::svrepdesign(data=dat3a, weights=~TOTWGT,type="JKn",
                 repweights='w_fstr[0-9]', scale=1,  rscales=rep(1,RR), mse=TRUE )
print(svydes3a)

#--- create survey object by converting the BIFIEdata object to survey
svydes3b <- BIFIEsurvey::BIFIEdata2svrepdesign(bdat3)

#--- convert survey object into BIFIEdata object
bdat3e <- BIFIEsurvey::svrepdesign2BIFIEdata(svrepdesign=svydes3b)

#*** compare results for the mean in Mathematics scores
mod1a <- BIFIEsurvey::BIFIE.univar( bdat3, vars="ASMMAT1")
mod1b <- survey::svymean( ~ ASMMAT1, design=svydes3a )
mod1c <- survey::svymean( ~ ASMMAT1, design=svydes3b )
lavmodel <- "ASMMAT1 ~ 1"
mod1d <- BIFIEsurvey::BIFIE.lavaan.survey(lavmodel, svyrepdes=svydes3b)

#- coefficients
coef(mod1a); coef(mod1b); coef(mod1c); coef(mod1d)[1]
#- standard errors
survey::SE(mod1a); survey::SE(mod1b); survey::SE(mod1c); sqrt(vcov(mod1d)[1,1])

#############################################################################
# EXAMPLE 2: Multiply imputed datasets, TIMSS replication design
#############################################################################

data(data.timss2)
data(data.timssrep)

#--- create BIFIEdata object
bdat4 <- BIFIEsurvey::BIFIE.data( data=data.timss2, wgt="TOTWGT",
              wgtrep=data.timssrep[,-1], fayfac=1)
print(bdat4)

#--- create object with imputed datasets in survey
datL <- mitools::imputationList( data.timss2 )
RR <- ncol(data.timssrep) - 1
weights <- data.timss2[[1]]$TOTWGT
repweights <-  data.timssrep[,-1]
svydes4a <- survey::svrepdesign(data=datL, weights=weights, type="other",
               repweights=repweights, scale=1,  rscales=rep(1,RR), mse=TRUE)
print(svydes4a)

#--- create BIFIEdata object with conversion function
svydes4b <- BIFIEsurvey::BIFIEdata2svrepdesign(bdat4)

#--- reconvert survey object into BIFIEdata object
bdat4c <- BIFIEsurvey::svrepdesign2BIFIEdata(svrepdesign=svydes4b)

#*** compare results for a mean
mod1a <- BIFIEsurvey::BIFIE.univar(bdat4, vars="ASMMAT")
mod1b <- mitools::MIcombine( with(svydes4a, survey::svymean( ~ ASMMAT, design=svydes4a )))
mod1c <- mitools::MIcombine( with(svydes4b, survey::svymean( ~ ASMMAT, design=svydes4b )))

# results
coef(mod1a); coef(mod1b); coef(mod1c)
survey::SE(mod1a); survey::SE(mod1b); survey::SE(mod1c)
} # }
```

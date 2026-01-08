# Data Transformation for `BIFIEdata` Objects

Computes a data transformation for `BIFIEdata` objects.

## Usage

``` r
BIFIE.data.transform( bifieobj, transform.formula, varnames.new=NULL )
```

## Arguments

- bifieobj:

  Object of class `BIFIEdata`

- transform.formula:

  R formula object for data transformation.

- varnames.new:

  Optional vector of names for new defined variables.

## Value

An object of class `BIFIEdata`. Additional values are

- varnames.added:

  Added variables in data transformation

- varsindex.added:

  Indices of added variables

## Examples

``` r
library(miceadds)
#> Loading required package: mice
#> 
#> Attaching package: ‘mice’
#> The following object is masked from ‘package:stats’:
#> 
#>     filter
#> The following objects are masked from ‘package:base’:
#> 
#>     cbind, rbind
#> * miceadds 3.18-36 (2025-09-12 09:54:54)

#############################################################################
# EXAMPLE 1: Data transformations for TIMSS data
#############################################################################

data(data.timss2)
data(data.timssrep)
# create BIFIEdata object
bifieobj1 <- BIFIEsurvey::BIFIE.data( data.timss2, wgt=data.timss2[[1]]$TOTWGT,
            wgtrep=data.timssrep[,-1] )
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|
# create BIFIEdata object in compact way (cdata=TRUE)
bifieobj2 <- BIFIEsurvey::BIFIE.data( data.timss2, wgt=data.timss2[[1]]$TOTWGT,
            wgtrep=data.timssrep[,-1], cdata=TRUE)
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|

#****************************
#*** Transformation 1: Squared and cubic book variable
transform.formula <- ~ I( books^2 ) + I( books^3 )
# as.character(transform.formula)
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj1,
                  transform.formula=transform.formula)
#> Included 2 variables: I(books^2) I(books^3)
bifieobj$variables
#>    index   variable variable_orig                        source
#> 1      1     IDSTUD        IDSTUD                        indata
#> 2      2     TOTWGT        TOTWGT                        indata
#> 3      3     JKZONE        JKZONE                        indata
#> 4      4      JKREP         JKREP                        indata
#> 5      5     female        female                        indata
#> 6      6      books         books                        indata
#> 7      7       lang          lang                        indata
#> 8      8    migrant       migrant                        indata
#> 9      9      scsci         scsci                        indata
#> 10    10     likesc        likesc                        indata
#> 11    11     ASMMAT        ASMMAT                        indata
#> 12    12     ASSSCI        ASSSCI                        indata
#> 13    13        one           one                        indata
#> 14    14 I(books^2)    I(books^2) ~ 0 + I(books^2) + I(books^3)
#> 15    15 I(books^3)    I(books^3) ~ 0 + I(books^2) + I(books^3)
# rename added variables
bifieobj$varnames[ bifieobj$varsindex.added ] <- c("books_sq", "books_cub")

# check descriptive statistics
res1 <- BIFIEsurvey::BIFIE.univar( bifieobj, vars=c("books_sq", "books_cub" ) )
#> |*****|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bifieobj, vars = c("books_sq", 
#>     "books_cub"))
#> 
#> Date of Analysis: 2026-01-08 12:41:07.220085 
#> Time difference of 0.04521489 secs
#> Computation time: 0.04521489 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Univariate Statistics | Means
#>         var  Nweight Ncases      M  M_SE M_df    M_t M_p M_fmi M_VarMI M_VarRep
#> 1  books_sq 76588.72   4554  9.986 0.240  Inf 41.606   0     0       0    0.058
#> 2 books_cub 76588.72   4554 37.472 1.207  Inf 31.050   0     0       0    1.456
#> 
#> Univariate Statistics | Standard Deviations
#>         var  Nweight Ncases     SD SD_SE SD_df   SD_t SD_p
#> 1  books_sq 76588.72   4554  7.194 0.109   Inf 91.596    0
#> 2 books_cub 76588.72   4554 38.414 0.715   Inf 52.375    0

if (FALSE) { # \dontrun{
#****************************
#*** Transformation 2: Create dummy variables for variable book
transform.formula <- ~ as.factor(books)
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj,
                    transform.formula=transform.formula )
##   Included 5 variables: as.factor(books)1 as.factor(books)2 as.factor(books)3
##        as.factor(books)4 as.factor(books)5
bifieobj$varnames[ bifieobj$varsindex.added ] <- paste0("books_D", 1:5)

#****************************
#*** Transformation 3: Discretized mathematics score
hi3a <- BIFIEsurvey::BIFIE.hist( bifieobj, vars="ASMMAT" )
plot(hi3a)
transform.formula <- ~ I( as.numeric(cut( ASMMAT, breaks=seq(200,800,100) )) )
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj,
                 transform.formula=transform.formula, varnames.new="ASMMAT_discret")
hi3b <- BIFIEsurvey::BIFIE.hist( bifieobj, vars="ASMMAT_discret", breaks=1:7 )
plot(hi3b)
# check frequencies
fr3b <- BIFIEsurvey::BIFIE.freq( bifieobj, vars="ASMMAT_discret", se=FALSE )
summary(fr3b)

#****************************
#*** Transformation 4: include standardization variables for book variable

# start with testing the transformation function on a single dataset
dat1 <- bifieobj$dat1
stats::weighted.mean( dat1[,"books"], dat1[,"TOTWGT"], na.rm=TRUE)
sqrt( Hmisc::wtd.var( dat1[,"books"], dat1[,"TOTWGT"], na.rm=TRUE) )
# z standardization
transform.formula <- ~ I( ( books - weighted.mean( books, TOTWGT, na.rm=TRUE) )/
                                sqrt( Hmisc::wtd.var( books, TOTWGT, na.rm=TRUE) ))
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj,
               transform.formula=transform.formula, varnames.new="z_books" )
# standardize variable books with M=500 and SD=100
transform.formula <- ~ I(
        500 + 100*( books - stats::weighted.mean( books, w=TOTWGT, na.rm=TRUE) ) /
              sqrt( Hmisc::wtd.var( books, weights=TOTWGT, na.rm=TRUE) )  )
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj,
             transform.formula=transform.formula, varnames.new="z500_books" )

# standardize variable books with respect to M and SD of ALL imputed datasets
res <- BIFIEsurvey::BIFIE.univar( bifieobj, vars="books" )
summary(res)
##       var  Nweight Ncases     M M_SE M_fmi M_VarMI M_VarRep    SD SD_SE SD_fmi
##   1 books 76588.72   4554 2.945 0.04     0       0    0.002 1.146 0.015      0
M <- round(res$output$mean1,5)
SD <- round(res$output$sd1,5)
transform.formula <- paste0( " ~ I( ( books - ",  M, " ) / ", SD, ")"  )
##   > transform.formula
##   [1] " ~ I( ( books - 2.94496 ) / 1.14609)"
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj,
                 transform.formula=stats::as.formula(transform.formula),
                 varnames.new="zall_books" )

# check statistics
res4 <- BIFIEsurvey::BIFIE.univar( bifieobj,
              vars=c("z_books", "z500_books", "zall_books") )
summary(res4)

#****************************
#*** Transformation 5: include rank transformation for variable ASMMAT

# calculate percentage ranks using wtd.rank function from Hmisc package
dat1 <- bifieobj$dat1
100 * Hmisc::wtd.rank( dat1[,"ASMMAT"], w=dat1[,"TOTWGT"] ) / sum( dat1[,"TOTWGT"] )
# define an auxiliary function for calculating percentage ranks
wtd.percrank <- function( x, w ){
    100 * Hmisc::wtd.rank( x, w, na.rm=TRUE ) / sum( w, na.rm=TRUE )
}
wtd.percrank( dat1[,"ASMMAT"], dat1[,"TOTWGT"] )
# define transformation formula
transform.formula <- ~ I( wtd.percrank( ASMMAT, TOTWGT ) )
# add ranks to BIFIEdata object
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj,
               transform.formula=transform.formula,  varnames.new="ASMMAT_rk")
# check statistic
res5 <- BIFIEsurvey::BIFIE.univar( bifieobj, vars=c("ASMMAT_rk" ) )
summary(res5)

#****************************
#*** Transformation 6: recode variable books

library(car)
# recode variable books according to "1,2=0, 3,4=1, 5=2"
dat1 <- bifieobj$dat1
# use Recode function from car package
car::Recode( dat1[,"books"], "1:2='0'; c(3,4)='1';5='2'")
# define transformation formula
transform.formula <- ~ I( car::Recode( books, "1:2='0'; c(3,4)='1';5='2'") )
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj,
               transform.formula=transform.formula,  varnames.new="book_rec" )
res6 <- BIFIEsurvey::BIFIE.freq( bifieobj, vars=c("book_rec" ) )
summary(res6)

#****************************
#*** Transformation 7: include some variables aggregated to the school level

dat1 <- as.data.frame(bifieobj$dat1)
# at first, create school ID in the dataset by transforming the student ID
dat1$idschool <- as.numeric(substring( dat1$IDSTUD, 1, 5 ))
transform.formula <- ~ I( as.numeric( substring( IDSTUD, 1, 5 ) ) )
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj,
               transform.formula=transform.formula, varnames.new="idschool" )

#*** test function for a single dataset bifieobj$dat1
dat1 <- as.data.frame(bifieobj$dat1)
gm <- miceadds::GroupMean( data=dat1$ASMMAT, group=dat1$idschool, extend=TRUE)[,2]

# add school mean ASMMAT
tformula <- ~ I( miceadds::GroupMean( ASMMAT, group=idschool, extend=TRUE)[,2] )
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj, transform.formula=tformula,
                varnames.new="M_ASMMAT" )
# add within group centered mathematics values of ASMMAT
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj,
                transform.formula=~ 0 + I( ASMMAT - M_ASMMAT ),
                varnames.new="WC_ASMMAT" )

# add school mean books
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj,
                transform.formula=~ 0 + I( add.groupmean( books, idschool ) ),
                varnames.new="M_books" )

#****************************
#*** Transformation 8: include fitted values and residuals from a linear model
# create new BIFIEdata object
data(data.timss1)
bifieobj3 <- BIFIEsurvey::BIFIE.data( data.timss1, wgt=data.timss1[[1]]$TOTWGT,
            wgtrep=data.timssrep[,-1] )

# specify transformation
transform.formula <- ~ I( fitted( stats::lm( ASMMAT ~ migrant + female ) ) ) +
                             I( residuals( stats::lm( ASMMAT ~ migrant + female ) ) )
  # Note that lm omits cases in regression by listwise deletion.
# add fitted values and residual to BIFIEdata object
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj3,
                  transform.formula=transform.formula )
bifieobj$varnames[ bifieobj$varsindex.added ] <- c("math_fitted1", "math_resid1")

#****************************
#*** Transformation 9: Including principal component scores in BIFIEdata object

# define auxiliary function for extracting PCA scores
BIFIE.princomp <- function( formula, Ncomp ){
    X <- stats::princomp( formula, cor=TRUE)
    Xp <- X$scores[, 1:Ncomp ]
    return(Xp)
}
# define transformation formula
transform.formula <- ~ I( BIFIE.princomp( ~ migrant + female + books + lang + ASMMAT, 3 ))
# apply transformation
bifieobj <- BIFIEsurvey::BIFIE.data.transform( bifieobj3,
                transform.formula=transform.formula )
bifieobj$varnames[ bifieobj$varsindex.added ] <- c("pca_sc1", "pca_sc2","pca_sc3")
# check descriptive statistics
res9 <- BIFIEsurvey::BIFIE.univar( bifieobj, vars="pca_sc1", se=FALSE)
summary(res9)
res9$output$mean1M

# The transformation formula can also be conveniently generated by string operations
vars <- c("migrant", "female", "books", "lang" )
transform.formula2 <- as.formula( paste0( "~ 0 + I ( BIFIE.princomp( ~ ",
       paste0( vars, collapse="+" ),  ", 3 ) )") )
  ##   > transform.formula2
  ##   ~ I(BIFIE.princomp(~migrant + female + books + lang, 3))

#****************************
#*** Transformation 10: Overwriting variables books and migrant
bifieobj4 <-  BIFIEsurvey::BIFIE.data.transform( bifieobj3,
                  transform.formula=~ I( 1*(books >=1 ) ) + I(2*migrant),
                  varnames.new=c("books","migrant") )
summary(bifieobj4)
} # }
```

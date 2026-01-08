# Create `BIFIE.data` Object based on Bootstrap

Creates a `BIFIE.data` object based on bootstrap designs. The sampling
is done assuming independence of cases.

## Usage

``` r
BIFIE.data.boot( data, wgt=NULL,  pv_vars=NULL,
         Nboot=500, seed=.Random.seed, cdata=FALSE)
```

## Arguments

- data:

  Data frame: Can be a single or a list of multiply imputed datasets

- wgt:

  A string indicating the label of case weight.

- pv_vars:

  An optional vector of plausible values which define multiply imputed
  datasets.

- Nboot:

  Number of bootstrap samples for usage

- seed:

  Simulation seed.

- cdata:

  An optional logical indicating whether the `BIFIEdata` object should
  be compactly saved. The default is `FALSE`.

## Value

Object of class `BIFIEdata`

## See also

[`BIFIE.data`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.md),
[`BIFIE.data.jack`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.jack.md)

## Examples

``` r
if (FALSE) { # \dontrun{
#############################################################################
# EXAMPLE 1: Bootstrap TIMSS data set
#############################################################################
data(data.timss1)

# bootstrap samples using weights
bifieobj1 <- BIFIEsurvey::BIFIE.data.boot( data.timss1, wgt="TOTWGT" )
summary(bifieobj1)

# bootstrap samples without weights
bifieobj2 <- BIFIEsurvey::BIFIE.data.boot( data.timss1  )
summary(bifieobj2)
} # }
```

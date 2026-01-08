# An Rcpp Based Version of the `table` Function

This is an Rcpp based version of the
[`base::table`](https://rdrr.io/r/base/table.html) function.

## Usage

``` r
bifietable(vec, sort.names=FALSE)
```

## Arguments

- vec:

  A numeric or character vector

- sort.names:

  An optional logical indicating whether values in the character vector
  should also be sorted in the table output

## Value

Same output like [`base::table`](https://rdrr.io/r/base/table.html)

## See also

[`base::table`](https://rdrr.io/r/base/table.html)

## Examples

``` r
data(data.timss1)
table( data.timss1[[1]][,"books"] )
#> 
#>    1    2    3    4    5 
#>  487 1209 1655  706  611 
BIFIEsurvey::bifietable( data.timss1[[1]][,"books"] )
#>    1    2    3    4    5 
#>  487 1209 1655  706  611 
```

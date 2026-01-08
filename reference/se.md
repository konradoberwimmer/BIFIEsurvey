# Standard Errors of Estimated Parameters

Outputs vector of standard errors of an estimated parameter vector.

## Usage

``` r
se(object)
```

## Arguments

- object:

  Object for which S3 method `vcov` can be applied

## Value

Vector

## See also

[`survey::SE`](https://rdrr.io/pkg/survey/man/SE.html)

## Examples

``` r
#############################################################################
# EXAMPLE 1: Toy example with lm function
#############################################################################

set.seed(906)
N <- 100
x <- seq(0,1,length=N)
y <- .6*x + stats::rnorm(N, sd=1)
mod <- stats::lm( y ~ x )
coef(mod)
#> (Intercept)           x 
#>  -0.2400624   0.9804859 
vcov(mod)
#>             (Intercept)           x
#> (Intercept)  0.04197905 -0.06265215
#> x           -0.06265215  0.12530431
se(mod)
#> (Intercept)           x 
#>   0.2048879   0.3539835 
summary(mod)
#> 
#> Call:
#> stats::lm(formula = y ~ x)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -2.63243 -0.66176 -0.01975  0.72220  2.57042 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)   
#> (Intercept)  -0.2401     0.2049  -1.172  0.24417   
#> x             0.9805     0.3540   2.770  0.00671 **
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 1.032 on 98 degrees of freedom
#> Multiple R-squared:  0.0726, Adjusted R-squared:  0.06314 
#> F-statistic: 7.672 on 1 and 98 DF,  p-value: 0.006709
#> 
```

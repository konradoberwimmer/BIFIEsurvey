# Analysis of Variance and Effect Sizes for Univariate Statistics

Computes a Wald test which tests equality of means (univariate analysis
of variance). In addition, the \\d\\ and \\\eta\\ effect sizes are
computed.

## Usage

``` r
BIFIE.univar.test(BIFIE.method, wald_test=TRUE)

# S3 method for class 'BIFIE.univar.test'
summary(object,digits=4,...)
```

## Arguments

- BIFIE.method:

  Object of class `BIFIE.univar`

- wald_test:

  Optional logical indicating whether a Wald test should be performed.

- object:

  Object of class `BIFIE.univar.test`

- digits:

  Number of digits for rounding output

- ...:

  Further arguments to be passed

## Value

A list with following entries

- stat.F:

  Data frame with \\F\\ statistic for Wald test

- stat.eta:

  Data frame with \\\eta\\ effect size and its inference

- stat.dstat:

  Data frame with Cohen's \\d\\ effect size and its inference

- ...:

  More values

## See also

[`BIFIE.univar`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.univar.md)

## Examples

``` r
#############################################################################
# EXAMPLE 1: Imputed TIMSS dataset - One grouping variable
#############################################################################

data(data.timss1)
data(data.timssrep)

# create BIFIE.dat object
bdat <- BIFIEsurvey::BIFIE.data( data.list=data.timss1, wgt=data.timss1[[1]]$TOTWGT,
           wgtrep=data.timssrep[, -1 ] )
#> +++ Generate BIFIE.data object
#> |*****|
#> |-----|

#**** Model 1: 3 variables splitted by book
res1 <- BIFIEsurvey::BIFIE.univar( bdat, vars=c("ASMMAT", "ASSSCI","scsci"),
                    group="books")
#> |*****|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat, vars = c("ASMMAT", 
#>     "ASSSCI", "scsci"), group = "books")
#> 
#> Date of Analysis: 2026-01-08 12:41:15.656383 
#> Time difference of 0.06618762 secs
#> Computation time: 0.06618762 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Univariate Statistics | Means
#>       var groupvar groupval   Nweight Ncases       M  M_SE   M_df     M_t M_p
#> 1  ASMMAT    books        1  7889.467  484.0 462.463 4.704  67.69  98.307   0
#> 2  ASMMAT    books        2 20602.693 1213.2 488.408 3.455 798.28 141.366   0
#> 3  ASMMAT    books        3 28233.896 1657.6 516.889 2.408 123.28 214.692   0
#> 4  ASMMAT    books        4 11754.811  708.8 532.942 3.158 125.24 168.760   0
#> 5  ASMMAT    books        5  9852.122  604.4 532.664 3.210 304.41 165.944   0
#> 6  ASSSCI    books        1  7889.467  484.0 474.183 5.900  38.76  80.374   0
#> 7  ASSSCI    books        2 20602.693 1213.2 507.314 4.099 102.59 123.778   0
#> 8  ASSSCI    books        3 28233.896 1657.6 542.211 2.591  54.59 209.306   0
#> 9  ASSSCI    books        4 11754.811  708.8 559.753 3.273  87.11 171.008   0
#> 10 ASSSCI    books        5  9852.122  604.4 563.601 3.495 103.83 161.264   0
#> 11  scsci    books        1  7889.467  484.0   2.132 0.060    Inf  35.316   0
#> 12  scsci    books        2 20602.693 1213.2   1.896 0.034    Inf  56.501   0
#> 13  scsci    books        3 28233.896 1657.6   1.771 0.025    Inf  71.743   0
#> 14  scsci    books        4 11754.811  708.8   1.652 0.034 381.58  49.151   0
#> 15  scsci    books        5  9852.122  604.4   1.654 0.038    Inf  43.270   0
#>    M_fmi M_VarMI M_VarRep
#> 1  0.243   4.483   16.750
#> 2  0.071   0.704   11.092
#> 3  0.180   0.870    4.752
#> 4  0.179   1.485    8.191
#> 5  0.115   0.984    9.122
#> 6  0.321   9.318   23.625
#> 7  0.197   2.764   13.481
#> 8  0.271   1.514    4.894
#> 9  0.214   1.913    8.418
#> 10 0.196   1.998    9.817
#> 11 0.031   0.000    0.004
#> 12 0.039   0.000    0.001
#> 13 0.033   0.000    0.001
#> 14 0.102   0.000    0.001
#> 15 0.061   0.000    0.001
#> 
#> Univariate Statistics | Standard Deviations
#>       var groupvar groupval   Nweight Ncases     SD SD_SE  SD_df    SD_t SD_p
#> 1  ASMMAT    books        1  7889.467  484.0 59.667 3.350  60.78 138.043    0
#> 2  ASMMAT    books        2 20602.693 1213.2 59.146 1.774 163.20 275.269    0
#> 3  ASMMAT    books        3 28233.896 1657.6 57.654 1.335  95.77 387.101    0
#> 4  ASMMAT    books        4 11754.811  708.8 57.709 1.863 640.19 286.114    0
#> 5  ASMMAT    books        5  9852.122  604.4 59.502 2.537  37.73 209.995    0
#> 6  ASSSCI    books        1  7889.467  484.0 71.334 3.286 642.31 144.321    0
#> 7  ASSSCI    books        2 20602.693 1213.2 66.532 1.806  91.17 280.916    0
#> 8  ASSSCI    books        3 28233.896 1657.6 62.825 1.643  22.53 329.936    0
#> 9  ASSSCI    books        4 11754.811  708.8 62.818 2.075 110.46 269.812    0
#> 10 ASSSCI    books        5  9852.122  604.4 62.951 2.759  64.39 204.256    0
#> 11  scsci    books        1  7889.467  484.0  1.049 0.027    Inf  77.933    0
#> 12  scsci    books        2 20602.693 1213.2  0.924 0.020    Inf  96.421    0
#> 13  scsci    books        3 28233.896 1657.6  0.815 0.020    Inf  86.572    0
#> 14  scsci    books        4 11754.811  708.8  0.786 0.032 972.60  51.580    0
#> 15  scsci    books        5  9852.122  604.4  0.851 0.031    Inf  53.503    0
#>    SD_fmi SD_VarMI SD_VarRep
#> 1   0.257    2.399     8.344
#> 2   0.157    0.411     2.655
#> 3   0.204    0.304     1.419
#> 4   0.079    0.229     3.195
#> 5   0.326    1.746     4.339
#> 6   0.079    0.710     9.943
#> 7   0.209    0.569     2.578
#> 8   0.421    0.948     1.563
#> 9   0.190    0.683     3.485
#> 10  0.249    1.581     5.716
#> 11  0.014    0.000     0.001
#> 12  0.035    0.000     0.000
#> 13  0.044    0.000     0.000
#> 14  0.064    0.000     0.001
#> 15  0.026    0.000     0.001
# analysis of variance
tres1 <- BIFIEsurvey::BIFIE.univar.test(res1)
#> |-----|
summary(tres1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar.test'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar.test(BIFIE.method = res1)
#> 
#> Date of Analysis: 2026-01-08 12:41:15.729692 
#> Time difference of 0.005145788 secs
#> Computation time: 0.005145788 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> F Test (ANOVA) 
#>   variable group      D1      D2 df1 D1_df2 D2_df2   D1_p   D2_p
#> 1   ASMMAT books 63.9526 29.3047   4   35.0    4.1 0.0000 0.0029
#> 2   ASSSCI books 59.3973 20.1403   4   40.7    2.9 0.0000 0.0181
#> 3    scsci books 17.1813 17.2584   4    6.4  350.9 0.0015 0.0000
#> 
#> Eta Squared 
#>      var group   eta2    eta eta_SE    fmi     df  VarMI VarRep
#> 1 ASMMAT books 0.1294 0.3597 0.0211 0.1954 104.79 0.0001 0.0004
#> 2 ASSSCI books 0.1564 0.3954 0.0206 0.0549    Inf 0.0000 0.0004
#> 3  scsci books 0.0254 0.1593 0.0194 0.0716 780.12 0.0000 0.0003
#> 
#> Cohen's d Statistic 
#>       var group groupval1 groupval2       M1       M2      SD       d   d_SE
#> 1  ASMMAT books         1         2 462.4629 488.4080 59.4069 -0.4373 0.0855
#> 2  ASMMAT books         1         3 462.4629 516.8889 58.6692 -0.9283 0.1007
#> 3  ASMMAT books         1         4 462.4629 532.9423 58.6959 -1.2013 0.1026
#> 4  ASMMAT books         1         5 462.4629 532.6644 59.5847 -1.1788 0.1153
#> 5  ASMMAT books         2         3 488.4080 516.8889 58.4049 -0.4876 0.0547
#> 6  ASMMAT books         2         4 488.4080 532.9423 58.4317 -0.7620 0.0655
#> 7  ASMMAT books         2         5 488.4080 532.6644 59.3245 -0.7459 0.0773
#> 8  ASMMAT books         3         4 516.8889 532.9423 57.6815 -0.2782 0.0578
#> 9  ASMMAT books         3         5 516.8889 532.6644 58.5857 -0.2692 0.0592
#> 10 ASMMAT books         4         5 532.9423 532.6644 58.6124  0.0046 0.0665
#> 11 ASSSCI books         1         2 474.1829 507.3136 68.9746 -0.4801 0.0935
#> 12 ASSSCI books         1         3 474.1829 542.2113 67.2139 -1.0119 0.0870
#> 13 ASSSCI books         1         4 474.1829 559.7534 67.2106 -1.2729 0.1097
#> 14 ASSSCI books         1         5 474.1829 563.6009 67.2732 -1.3290 0.1122
#> 15 ASSSCI books         2         3 507.3136 542.2113 64.7048 -0.5395 0.0583
#> 16 ASSSCI books         2         4 507.3136 559.7534 64.7014 -0.8104 0.0656
#> 17 ASSSCI books         2         5 507.3136 563.6009 64.7664 -0.8693 0.0913
#> 18 ASSSCI books         3         4 542.2113 559.7534 62.8211 -0.2790 0.0591
#> 19 ASSSCI books         3         5 542.2113 563.6009 62.8880 -0.3402 0.0680
#> 20 ASSSCI books         4         5 559.7534 563.6009 62.8845 -0.0614 0.0761
#> 21  scsci books         1         2   2.1318   1.8956  0.9881  0.2390 0.0626
#> 22  scsci books         1         3   2.1318   1.7712  0.9393  0.3839 0.0635
#> 23  scsci books         1         4   2.1318   1.6515  0.9267  0.5183 0.0781
#> 24  scsci books         1         5   2.1318   1.6542  0.9549  0.5001 0.0675
#> 25  scsci books         2         3   1.8956   1.7712  0.8710  0.1428 0.0468
#> 26  scsci books         2         4   1.8956   1.6515  0.8575  0.2847 0.0551
#> 27  scsci books         2         5   1.8956   1.6542  0.8879  0.2719 0.0587
#> 28  scsci books         3         4   1.7712   1.6515  0.8007  0.1496 0.0517
#> 29  scsci books         3         5   1.7712   1.6542  0.8331  0.1405 0.0563
#> 30  scsci books         4         5   1.6515   1.6542  0.8189 -0.0033 0.0620
#>         d_t   d_df    d_p  d_fmi d_VarMI d_VarRep
#> 1   -5.1124  24.48 0.0000 0.4043  0.0025   0.0044
#> 2   -9.2220  22.31 0.0000 0.4235  0.0036   0.0058
#> 3  -11.7108  53.95 0.0000 0.2723  0.0024   0.0077
#> 4  -10.2246  55.71 0.0000 0.2680  0.0030   0.0097
#> 5   -8.9169 424.49 0.0000 0.0971  0.0002   0.0027
#> 6  -11.6320 168.14 0.0000 0.1542  0.0006   0.0036
#> 7   -9.6437 634.38 0.0000 0.0794  0.0004   0.0055
#> 8   -4.8112 141.20 0.0000 0.1683  0.0005   0.0028
#> 9   -4.5455    Inf 0.0000 0.0461  0.0001   0.0033
#> 10   0.0694    Inf 0.9447 0.0363  0.0001   0.0043
#> 11  -5.1361  22.78 0.0000 0.4190  0.0031   0.0051
#> 12 -11.6292 110.22 0.0000 0.1905  0.0012   0.0061
#> 13 -11.5999  49.89 0.0000 0.2832  0.0028   0.0086
#> 14 -11.8402 303.11 0.0000 0.1149  0.0012   0.0112
#> 15  -9.2531  90.19 0.0000 0.2106  0.0006   0.0027
#> 16 -12.3568    Inf 0.0000 0.0458  0.0002   0.0041
#> 17  -9.5183  49.51 0.0000 0.2842  0.0020   0.0060
#> 18  -4.7233  50.06 0.0000 0.2827  0.0008   0.0025
#> 19  -5.0018  61.59 0.0000 0.2548  0.0010   0.0034
#> 20  -0.8066  28.12 0.4267 0.3771  0.0018   0.0036
#> 21   3.8163    Inf 0.0001 0.0134  0.0000   0.0039
#> 22   6.0471    Inf 0.0000 0.0486  0.0002   0.0038
#> 23   6.6358 758.33 0.0000 0.0726  0.0004   0.0057
#> 24   7.4094 962.53 0.0000 0.0645  0.0002   0.0043
#> 25   3.0497    Inf 0.0023 0.0483  0.0001   0.0021
#> 26   5.1677 907.26 0.0000 0.0664  0.0002   0.0028
#> 27   4.6313 666.69 0.0000 0.0775  0.0002   0.0032
#> 28   2.8922 351.10 0.0041 0.1067  0.0002   0.0024
#> 29   2.4963    Inf 0.0126 0.0199  0.0001   0.0031
#> 30  -0.0537 220.77 0.9572 0.1346  0.0004   0.0033

#**** Model 2: One variable splitted by gender
res2 <- BIFIEsurvey::BIFIE.univar( bdat, vars=c("ASMMAT"), group="female" )
#> |*****|
#> |-----|
summary(res2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar(BIFIEobj = bdat, vars = c("ASMMAT"), 
#>     group = "female")
#> 
#> Date of Analysis: 2026-01-08 12:41:15.743568 
#> Time difference of 0.02263546 secs
#> Computation time: 0.02263546 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Univariate Statistics | Means
#>      var groupvar groupval  Nweight Ncases       M  M_SE   M_df     M_t M_p
#> 1 ASMMAT   female        0 40129.77 2388.6 512.851 3.256    Inf 157.526   0
#> 2 ASMMAT   female        1 38203.22 2279.4 503.542 2.605 454.07 193.306   0
#>   M_fmi M_VarMI M_VarRep
#> 1 0.028   0.247   10.303
#> 2 0.094   0.531    6.149
#> 
#> Univariate Statistics | Standard Deviations
#>      var groupvar groupval  Nweight Ncases     SD SD_SE  SD_df    SD_t SD_p
#> 1 ASMMAT   female        0 40129.77 2388.6 63.484 1.379  78.52 372.009    0
#> 2 ASMMAT   female        1 38203.22 2279.4 61.496 1.325 102.78 380.057    0
#>   SD_fmi SD_VarMI SD_VarRep
#> 1  0.226    0.357     1.472
#> 2  0.197    0.289     1.409
# analysis of variance
tres2 <- BIFIEsurvey::BIFIE.univar.test(res2)
#> |-----|
summary(tres2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.univar.test'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.univar.test(BIFIE.method = res2)
#> 
#> Date of Analysis: 2026-01-08 12:41:15.772296 
#> Time difference of 0.001671314 secs
#> Computation time: 0.001671314 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> F Test (ANOVA) 
#>   variable  group     D1    D2 df1 D1_df2 D2_df2   D1_p  D2_p
#> 1   ASMMAT female 12.048 11.37   1      4  105.3 0.0256 0.001
#> 
#> Eta Squared 
#>      var  group   eta2    eta eta_SE    fmi  df VarMI VarRep
#> 1 ASMMAT female 0.0055 0.0742 0.0207 0.0628 Inf     0 0.0004
#> 
#> Cohen's d Statistic 
#>      var  group groupval1 groupval2       M1       M2      SD      d   d_SE
#> 1 ASMMAT female         0         1 512.8511 503.5417 62.4978 0.1489 0.0417
#>      d_t d_df    d_p d_fmi d_VarMI d_VarRep
#> 1 3.5694  Inf 0.0004 0.063  0.0001   0.0016

if (FALSE) { # \dontrun{
#**** Model 3: Univariate statistic: math
res3 <- BIFIEsurvey::BIFIE.univar( bdat, vars=c("ASMMAT") )
summary(res3)
tres3 <- BIFIEsurvey::BIFIE.univar.test(res3)

#############################################################################
# EXAMPLE 2: Imputed TIMSS dataset - Two grouping variables
#############################################################################

data(data.timss1)
data(data.timssrep)

# create BIFIE.dat object
bdat <- BIFIEsurvey::BIFIE.data( data.list=data.timss1, wgt=data.timss1[[1]]$TOTWGT,
                  wgtrep=data.timssrep[, -1 ] )

#**** Model 1: 3 variables splitted by book and female
res1 <- BIFIEsurvey::BIFIE.univar(bdat, vars=c("ASMMAT", "ASSSCI","scsci"),
                  group=c("books","female"))
summary(res1)

# analysis of variance
tres1 <- BIFIEsurvey::BIFIE.univar.test(res1)
summary(tres1)

# extract data frame with Cohens d statistic
dstat <- tres1$stat.dstat

# extract d values for gender comparisons with same value of books
# -> 'books' refers to the first variable
ind <- which(
  unlist( lapply( strsplit( dstat$groupval1, "#"), FUN=function(vv){vv[1]}) )==
  unlist( lapply( strsplit( dstat$groupval2, "#"), FUN=function(vv){vv[1]}) )
        )
dstat[ ind, ]
} # }
```

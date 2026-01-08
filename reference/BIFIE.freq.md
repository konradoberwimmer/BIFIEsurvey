# Frequency Statistics

Computes absolute and relative frequencies.

## Usage

``` r
BIFIE.freq(BIFIEobj, vars, group=NULL, group_values=NULL, se=TRUE)

# S3 method for class 'BIFIE.freq'
summary(object,digits=3,...)

# S3 method for class 'BIFIE.freq'
coef(object,...)

# S3 method for class 'BIFIE.freq'
vcov(object,...)
```

## Arguments

- BIFIEobj:

  Object of class `BIFIEdata`

- vars:

  Vector of variables for which statistics should be computed

- group:

  Optional grouping variable(s)

- group_values:

  Optional vector of grouping values. This can be omitted and grouping
  values will be determined automatically.

- se:

  Optional logical indicating whether statistical inference based on
  replication should be employed.

- object:

  Object of class `BIFIE.freq`

- digits:

  Number of digits for rounding output

- ...:

  Further arguments to be passed

## Value

A list with following entries

- stat:

  Data frame with frequency statistics

- output:

  Extensive output with all replicated statistics

- ...:

  More values

## See also

[`survey::svytable`](https://rdrr.io/pkg/survey/man/svychisq.html),
[`intsvy::timss.table`](https://rdrr.io/pkg/intsvy/man/timss.table.html),
[`Hmisc::wtd.table`](https://rdrr.io/pkg/Hmisc/man/wtd.stats.html)

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

# Frequencies for three variables
res1 <- BIFIEsurvey::BIFIE.freq( bdat, vars=c("lang", "books", "migrant" )  )
#> |*****|
#> |-----|
summary(res1)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.freq'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.freq(BIFIEobj = bdat, vars = c("lang", "books", 
#>     "migrant"))
#> 
#> Date of Analysis: 2026-01-08 12:41:11.361409 
#> Time difference of 0.06265664 secs
#> Computation time: 0.06265664 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Relative Frequencies 
#>        var varval Ncases   Nweight  perc perc_SE perc_fmi perc_df perc_VarMI
#> 1     lang      1 3472.2 60121.843 0.768   0.011    0.007     Inf          0
#> 2     lang      2 1036.4 15564.696 0.199   0.010    0.008     Inf          0
#> 3     lang      3  159.4  2646.451 0.034   0.003    0.004     Inf          0
#> 4    books      1  484.0  7889.467 0.101   0.008    0.005     Inf          0
#> 5    books      2 1213.2 20602.693 0.263   0.012    0.009     Inf          0
#> 6    books      3 1657.6 28233.896 0.360   0.010    0.004     Inf          0
#> 7    books      4  708.8 11754.811 0.150   0.008    0.032     Inf          0
#> 8    books      5  604.4  9852.122 0.126   0.008    0.017     Inf          0
#> 9  migrant      0 3614.6 62800.351 0.802   0.013    0.004     Inf          0
#> 10 migrant      1 1053.4 15532.639 0.198   0.013    0.004     Inf          0
#>    perc_VarRep
#> 1            0
#> 2            0
#> 3            0
#> 4            0
#> 5            0
#> 6            0
#> 7            0
#> 8            0
#> 9            0
#> 10           0

# Frequencies splitted by gender
res2 <- BIFIEsurvey::BIFIE.freq( bdat, vars=c("lang", "books", "migrant" ),
              group="female", group_values=0:1 )
#> |*****|
#> |-----|
summary(res2)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.freq'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.freq(BIFIEobj = bdat, vars = c("lang", "books", 
#>     "migrant"), group = "female", group_values = 0:1)
#> 
#> Date of Analysis: 2026-01-08 12:41:11.428059 
#> Time difference of 0.06392336 secs
#> Computation time: 0.06392336 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Relative Frequencies 
#>        var varval groupvar groupval Ncases   Nweight  perc perc_SE perc_fmi
#> 1     lang      1   female        0 1797.0 31154.878 0.776   0.013    0.008
#> 2     lang      2   female        0  491.6  7335.872 0.183   0.012    0.010
#> 3     lang      3   female        0  100.0  1639.017 0.041   0.005    0.002
#> 4     lang      1   female        1 1675.2 28966.965 0.758   0.013    0.012
#> 5     lang      2   female        1  544.8  8228.824 0.215   0.013    0.014
#> 6     lang      3   female        1   59.4  1007.434 0.026   0.003    0.009
#> 7    books      1   female        0  314.0  5258.437 0.131   0.011    0.007
#> 8    books      2   female        0  612.2 10649.303 0.265   0.013    0.020
#> 9    books      3   female        0  799.6 13544.086 0.338   0.013    0.010
#> 10   books      4   female        0  325.4  5292.094 0.132   0.008    0.018
#> 11   books      5   female        0  337.4  5385.847 0.134   0.011    0.010
#> 12   books      1   female        1  170.0  2631.030 0.069   0.008    0.002
#> 13   books      2   female        1  601.0  9953.390 0.261   0.015    0.011
#> 14   books      3   female        1  858.0 14689.810 0.385   0.013    0.009
#> 15   books      4   female        1  383.4  6462.717 0.169   0.011    0.027
#> 16   books      5   female        1  267.0  4466.275 0.117   0.009    0.039
#> 17 migrant      0   female        0 1857.6 32318.004 0.805   0.014    0.006
#> 18 migrant      1   female        0  531.0  7811.763 0.195   0.014    0.006
#> 19 migrant      0   female        1 1757.0 30482.347 0.798   0.014    0.015
#> 20 migrant      1   female        1  522.4  7720.876 0.202   0.014    0.015
#>    perc_df perc_VarMI perc_VarRep
#> 1      Inf          0           0
#> 2      Inf          0           0
#> 3      Inf          0           0
#> 4      Inf          0           0
#> 5      Inf          0           0
#> 6      Inf          0           0
#> 7      Inf          0           0
#> 8      Inf          0           0
#> 9      Inf          0           0
#> 10     Inf          0           0
#> 11     Inf          0           0
#> 12     Inf          0           0
#> 13     Inf          0           0
#> 14     Inf          0           0
#> 15     Inf          0           0
#> 16     Inf          0           0
#> 17     Inf          0           0
#> 18     Inf          0           0
#> 19     Inf          0           0
#> 20     Inf          0           0

# Frequencies splitted by gender and likesc
res3 <- BIFIEsurvey::BIFIE.freq( bdat, vars=c("lang", "books", "migrant" ),
              group=c("likesc","female")  )
#> |*****|
#> |-----|
summary(res3)
#> ------------------------------------------------------------
#> BIFIEsurvey 3.8.0 () 
#> 
#> Function 'BIFIE.freq'
#> 
#> Call:
#> BIFIEsurvey::BIFIE.freq(BIFIEobj = bdat, vars = c("lang", "books", 
#>     "migrant"), group = c("likesc", "female"))
#> 
#> Date of Analysis: 2026-01-08 12:41:11.496388 
#> Time difference of 0.09032679 secs
#> Computation time: 0.09032679 
#> 
#> Multiply imputed dataset
#> 
#> Number of persons = 4668 
#> Number of imputed datasets = 5 
#> Number of Jackknife zones per dataset = 75 
#> Fay factor = 1 
#> 
#> Relative Frequencies 
#>        var varval groupvar1 groupval1 groupvar2 groupval2 Ncases   Nweight
#> 1     lang      1    likesc         1    female         0  476.8  7753.657
#> 2     lang      2    likesc         1    female         0  184.4  2629.250
#> 3     lang      3    likesc         1    female         0   35.0   578.736
#> 4     lang      1    likesc         2    female         0  636.2 10861.713
#> 5     lang      2    likesc         2    female         0  160.4  2433.276
#> 6     lang      3    likesc         2    female         0   30.0   437.579
#> 7     lang      1    likesc         3    female         0  340.2  5988.767
#> 8     lang      2    likesc         3    female         0   66.2  1084.629
#> 9     lang      3    likesc         3    female         0   12.4   227.984
#> 10    lang      1    likesc         4    female         0  343.8  6550.741
#> 11    lang      2    likesc         4    female         0   80.6  1188.717
#> 12    lang      3    likesc         4    female         0   22.6   394.717
#> 13    lang      1    likesc         1    female         1  664.8 11056.357
#> 14    lang      2    likesc         1    female         1  291.4  4274.646
#> 15    lang      3    likesc         1    female         1   27.0   486.130
#> 16    lang      1    likesc         2    female         1  704.0 12411.598
#> 17    lang      2    likesc         2    female         1  188.8  2985.935
#> 18    lang      3    likesc         2    female         1   22.4   368.309
#> 19    lang      1    likesc         3    female         1  219.8  3973.145
#> 20    lang      2    likesc         3    female         1   44.0   650.916
#> 21    lang      3    likesc         3    female         1    7.0   107.634
#> 22    lang      1    likesc         4    female         1   86.6  1525.865
#> 23    lang      2    likesc         4    female         1   20.6   317.328
#> 24    lang      3    likesc         4    female         1    3.0    45.360
#> 25   books      1    likesc         1    female         0   93.4  1351.248
#> 26   books      2    likesc         1    female         0  182.6  3088.496
#> 27   books      3    likesc         1    female         0  219.6  3414.338
#> 28   books      4    likesc         1    female         0   94.2  1402.450
#> 29   books      5    likesc         1    female         0  106.4  1705.110
#> 30   books      1    likesc         2    female         0   89.0  1514.176
#> 31   books      2    likesc         2    female         0  210.8  3586.583
#> 32   books      3    likesc         2    female         0  291.8  4969.593
#> 33   books      4    likesc         2    female         0  119.8  1865.415
#> 34   books      5    likesc         2    female         0  115.2  1796.799
#> 35   books      1    likesc         3    female         0   53.2   873.236
#> 36   books      2    likesc         3    female         0   99.8  1882.140
#> 37   books      3    likesc         3    female         0  155.4  2655.844
#> 38   books      4    likesc         3    female         0   60.8  1078.228
#> 39   books      5    likesc         3    female         0   49.6   811.932
#> 40   books      1    likesc         4    female         0   78.4  1519.777
#> 41   books      2    likesc         4    female         0  119.0  2092.083
#> 42   books      3    likesc         4    female         0  132.8  2504.310
#> 43   books      4    likesc         4    female         0   50.6   946.000
#> 44   books      5    likesc         4    female         0   66.2  1072.006
#> 45   books      1    likesc         1    female         1   88.4  1265.480
#> 46   books      2    likesc         1    female         1  256.0  4023.914
#> 47   books      3    likesc         1    female         1  355.6  5733.673
#> 48   books      4    likesc         1    female         1  159.2  2650.750
#> 49   books      5    likesc         1    female         1  124.0  2143.315
#> 50   books      1    likesc         2    female         1   47.6   671.864
#> 51   books      2    likesc         2    female         1  247.6  4277.250
#> 52   books      3    likesc         2    female         1  367.2  6489.977
#> 53   books      4    likesc         2    female         1  158.0  2805.028
#> 54   books      5    likesc         2    female         1   94.8  1521.723
#> 55   books      1    likesc         3    female         1   17.0   389.928
#> 56   books      2    likesc         3    female         1   67.4  1178.250
#> 57   books      3    likesc         3    female         1  100.0  1744.478
#> 58   books      4    likesc         3    female         1   47.6   745.944
#> 59   books      5    likesc         3    female         1   38.8   673.095
#> 60   books      1    likesc         4    female         1   17.0   303.758
#> 61   books      2    likesc         4    female         1   30.0   473.977
#> 62   books      3    likesc         4    female         1   35.2   721.682
#> 63   books      4    likesc         4    female         1   18.6   260.995
#> 64   books      5    likesc         4    female         1    9.4   128.141
#> 65 migrant      0    likesc         1    female         0  484.6  8064.777
#> 66 migrant      1    likesc         1    female         0  211.6  2896.866
#> 67 migrant      0    likesc         2    female         0  653.4 11162.898
#> 68 migrant      1    likesc         2    female         0  173.2  2569.669
#> 69 migrant      0    likesc         3    female         0  356.4  6313.157
#> 70 migrant      1    likesc         3    female         0   62.4   988.223
#> 71 migrant      0    likesc         4    female         0  363.2  6777.172
#> 72 migrant      1    likesc         4    female         0   83.8  1357.005
#> 73 migrant      0    likesc         1    female         1  688.0 11482.736
#> 74 migrant      1    likesc         1    female         1  295.2  4334.397
#> 75 migrant      0    likesc         2    female         1  744.0 13166.386
#> 76 migrant      1    likesc         2    female         1  171.2  2599.456
#> 77 migrant      0    likesc         3    female         1  229.4  4184.403
#> 78 migrant      1    likesc         3    female         1   41.4   547.292
#> 79 migrant      0    likesc         4    female         1   95.6  1648.823
#> 80 migrant      1    likesc         4    female         1   14.6   239.730
#>     perc perc_SE perc_fmi perc_df perc_VarMI perc_VarRep
#> 1  0.707   0.019    0.018     Inf          0       0.000
#> 2  0.240   0.018    0.023     Inf          0       0.000
#> 3  0.053   0.011    0.038     Inf          0       0.000
#> 4  0.791   0.016    0.005     Inf          0       0.000
#> 5  0.177   0.015    0.018     Inf          0       0.000
#> 6  0.032   0.006    0.019     Inf          0       0.000
#> 7  0.820   0.027    0.029     Inf          0       0.001
#> 8  0.149   0.027    0.019     Inf          0       0.001
#> 9  0.031   0.011    0.013     Inf          0       0.000
#> 10 0.805   0.024    0.052     Inf          0       0.001
#> 11 0.146   0.020    0.067  890.03          0       0.000
#> 12 0.049   0.012    0.006     Inf          0       0.000
#> 13 0.699   0.021    0.035     Inf          0       0.000
#> 14 0.270   0.020    0.039     Inf          0       0.000
#> 15 0.031   0.006    0.000     Inf          0       0.000
#> 16 0.787   0.017    0.029     Inf          0       0.000
#> 17 0.189   0.016    0.034     Inf          0       0.000
#> 18 0.023   0.006    0.020     Inf          0       0.000
#> 19 0.840   0.021    0.014     Inf          0       0.000
#> 20 0.138   0.018    0.020     Inf          0       0.000
#> 21 0.023   0.009    0.000     Inf          0       0.000
#> 22 0.808   0.044    0.021     Inf          0       0.002
#> 23 0.168   0.042    0.025     Inf          0       0.002
#> 24 0.024   0.015    0.001     Inf          0       0.000
#> 25 0.123   0.015    0.074  740.15          0       0.000
#> 26 0.282   0.027    0.019     Inf          0       0.001
#> 27 0.311   0.018    0.019     Inf          0       0.000
#> 28 0.128   0.017    0.014     Inf          0       0.000
#> 29 0.156   0.018    0.086  540.97          0       0.000
#> 30 0.110   0.017    0.008     Inf          0       0.000
#> 31 0.261   0.016    0.030     Inf          0       0.000
#> 32 0.362   0.021    0.056     Inf          0       0.000
#> 33 0.136   0.012    0.027     Inf          0       0.000
#> 34 0.131   0.014    0.019     Inf          0       0.000
#> 35 0.120   0.020    0.043     Inf          0       0.000
#> 36 0.258   0.030    0.099  408.77          0       0.001
#> 37 0.364   0.032    0.111  324.61          0       0.001
#> 38 0.148   0.019    0.029     Inf          0       0.000
#> 39 0.111   0.019    0.051     Inf          0       0.000
#> 40 0.187   0.024    0.049     Inf          0       0.001
#> 41 0.257   0.027    0.022     Inf          0       0.001
#> 42 0.308   0.029    0.045     Inf          0       0.001
#> 43 0.116   0.016    0.015     Inf          0       0.000
#> 44 0.132   0.019    0.041     Inf          0       0.000
#> 45 0.080   0.008    0.016     Inf          0       0.000
#> 46 0.254   0.021    0.030     Inf          0       0.000
#> 47 0.363   0.020    0.030     Inf          0       0.000
#> 48 0.168   0.014    0.036     Inf          0       0.000
#> 49 0.136   0.015    0.047     Inf          0       0.000
#> 50 0.043   0.008    0.028     Inf          0       0.000
#> 51 0.271   0.020    0.015     Inf          0       0.000
#> 52 0.412   0.019    0.011     Inf          0       0.000
#> 53 0.178   0.018    0.011     Inf          0       0.000
#> 54 0.097   0.013    0.026     Inf          0       0.000
#> 55 0.082   0.035    0.004     Inf          0       0.001
#> 56 0.249   0.031    0.036     Inf          0       0.001
#> 57 0.369   0.035    0.010     Inf          0       0.001
#> 58 0.158   0.024    0.032     Inf          0       0.001
#> 59 0.142   0.026    0.019     Inf          0       0.001
#> 60 0.161   0.037    0.006     Inf          0       0.001
#> 61 0.251   0.048    0.020     Inf          0       0.002
#> 62 0.382   0.052    0.070  825.93          0       0.003
#> 63 0.138   0.034    0.037     Inf          0       0.001
#> 64 0.068   0.022    0.212   89.41          0       0.000
#> 65 0.736   0.020    0.006     Inf          0       0.000
#> 66 0.264   0.020    0.006     Inf          0       0.000
#> 67 0.813   0.018    0.016     Inf          0       0.000
#> 68 0.187   0.018    0.016     Inf          0       0.000
#> 69 0.865   0.035    0.013     Inf          0       0.001
#> 70 0.135   0.035    0.013     Inf          0       0.001
#> 71 0.833   0.020    0.037     Inf          0       0.000
#> 72 0.167   0.020    0.037     Inf          0       0.000
#> 73 0.726   0.020    0.021     Inf          0       0.000
#> 74 0.274   0.020    0.021     Inf          0       0.000
#> 75 0.835   0.019    0.049     Inf          0       0.000
#> 76 0.165   0.019    0.049     Inf          0       0.000
#> 77 0.884   0.022    0.031     Inf          0       0.000
#> 78 0.116   0.022    0.031     Inf          0       0.000
#> 79 0.873   0.039    0.043     Inf          0       0.001
#> 80 0.127   0.039    0.043     Inf          0       0.001
```

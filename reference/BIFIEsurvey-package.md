# Tools for Survey Statistics in Educational Assessment

Contains tools for survey statistics (especially in educational
assessment) for datasets with replication designs (jackknife, bootstrap,
replicate weights; see Kolenikov, 2010; Pfefferman & Rao, 2009a, 2009b,
\<doi:10.1016/S0169-7161(09)70003-3\>,
\<doi:10.1016/S0169-7161(09)70037-9\>); Shao, 1996,
\<doi:10.1080/02331889708802523\>). Descriptive statistics, linear and
logistic regression, path models for manifest variables with measurement
error correction and two-level hierarchical regressions for weighted
samples are included. Statistical inference can be conducted for
multiply imputed datasets and nested multiply imputed datasets and is in
particularly suited for the analysis of plausible values (for details
see George, Oberwimmer & Itzlinger-Bruneforth, 2016; Bruneforth,
Oberwimmer & Robitzsch, 2016; Robitzsch, Pham & Yanagida, 2016). The
package development was supported by BIFIE (Federal Institute for
Educational Research, Innovation and Development of the Austrian School
System; Salzburg, Austria).

## Author

BIFIE \[aut\], Alexander Robitzsch \[aut\], Konrad Oberwimmer \[aut,
cre\]

Maintainer: Konrad Oberwimmer \<konrad.oberwimmer@iqs.gv.at\>

## Details

The BIFIEsurvey package include basic descriptive functions for large
scale assessment data to complement the more comprehensive survey
package. The functions in this package were written in Rcpp.

The features of BIFIEsurvey include for designs with replicate weights
(which includes Jackknife and Bootstrap as general approaches):

- Descriptive statistics: means and standard deviations
  ([`BIFIE.univar`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.univar.md)),
  frequencies
  ([`BIFIE.freq`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.freq.md)),
  crosstabs
  ([`BIFIE.crosstab`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.crosstab.md))

- Linear regression
  ([`BIFIE.linreg`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.linreg.md))

- Logistic regression
  ([`BIFIE.logistreg`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.logistreg.md))

- Path models with measurement error correction for manifest variables
  ([`BIFIE.pathmodel`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.pathmodel.md))

- Two-level regression for hierarchical data
  ([`BIFIE.twolevelreg`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.twolevelreg.md);
  random slope model)

- Statistical inference for derived parameters
  ([`BIFIE.derivedParameters`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.derivedParameters.md))

- Wald tests
  ([`BIFIE.waldtest`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.waldtest.md))
  of model parameters based on replicated statistics

- User-defined R functions
  ([`BIFIE.by`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.by.md))

## References

Bruneforth, M., Oberwimmer, K., & Robitzsch, A. (2016). Reporting und
Analysen. In S. Breit & C. Schreiner (Hrsg.). *Large-Scale Assessment
mit R: Methodische Grundlagen der oesterreichischen
Bildungsstandardueberpruefung* (S. 333-362). Wien: facultas.

George, A. C., Oberwimmer, K., & Itzlinger-Bruneforth, U. (2016).
Stichprobenziehung. In S. Breit & C. Schreiner (Hrsg.). *Large-Scale
Assessment mit R: Methodische Grundlagen der oesterreichischen
Bildungsstandardueberpruefung* (S. 51-81). Wien: facultas.

Kolenikov, S. (2010). Resampling variance estimation for complex survey
data. *Stata Journal, 10*(2), 165-199.

Pfefferman, D., & Rao, C. R. (2009a). *Handbook of statistics, Vol. 29A:
Sample surveys: Design, methods and applications*. Amsterdam: North
Holland.

Pfefferman, D., & Rao, C. R. (2009b). *Handbook of statistics, Vol. 29B:
Sample surveys: Inference and analysis*. Amsterdam: North Holland.

Robitzsch, A., Pham, G., & Yanagida, T. (2016). Fehlende Daten und
Plausible Values. In S. Breit & C. Schreiner (Hrsg.). *Large-Scale
Assessment mit R: Methodische Grundlagen der oesterreichischen
Bildungsstandardueberpruefung* (S. 259-293). Wien: facultas.

Shao, J. (1996). Invited discussion paper: Resampling methods in sample
surveys. *Statistics, 27*(3-4), 203-237.

## See also

See also the survey, intsvy, EdSurvey, **lavaan.survey**, EVER and the
eatRep packages.

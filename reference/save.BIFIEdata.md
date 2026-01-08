# Saving, Writing and Loading `BIFIEdata` Objects

These functions save (`save.BIFIEdata`), write (`write.BIFIEdata`) or
load (`load.BIFIEdata`) objects of class `BIFIEdata`.

The function `load.BIFIEdata.files` allows the creation of `BIFIEdata`
objects by loading separate files of imputed datasets, replicate weights
and a possible indicator dataset.

## Usage

``` r
save.BIFIEdata(BIFIEdata, name.BIFIEdata, cdata=TRUE, varnames=NULL)

write.BIFIEdata( BIFIEdata, name.BIFIEdata, dir=getwd(), varnames=NULL,
    impdata.index=NULL, type="Rdata", ... )

load.BIFIEdata(filename, dir=getwd() )

load.BIFIEdata.files( files.imp, wgt, file.wgtrep, file.ind=NULL,
    type="Rdata",varnames=NULL, cdata=TRUE, dir=getwd(), ... )
```

## Arguments

- BIFIEdata:

  Object of class `BIFIEdata`

- name.BIFIEdata:

  Name of `BIFIEdata` set to be saved

- cdata:

  An optional logical indicating whether the dataset should be saved in
  a 'compact way'

- varnames:

  Vector of variable names which should be saved. The default is to use
  all variables.

- dir:

  Directory in which data files should be saved. The default is the
  working directory.

- impdata.index:

  Vector of indices for selecting imputed datasets

- type:

  Type of saved data. Options are `Rdata` (function
  [`base::save`](https://rdrr.io/r/base/save.html), `csv` (function
  [`utils::write.csv`](https://rdrr.io/r/utils/write.table.html)),
  `csv2` (function
  [`utils::write.csv2`](https://rdrr.io/r/utils/write.table.html)),
  `table` (function
  [`utils::write.table`](https://rdrr.io/r/utils/write.table.html)),
  `sav` (function
  [`foreign::read.spss`](https://rdrr.io/pkg/foreign/man/read.spss.html)
  for reading sav files and function `sjlabelled::write_spss` for
  writing sav files).

- ...:

  Additional arguments to be passed to
  [`base::save`](https://rdrr.io/r/base/save.html),
  [`utils::write.csv`](https://rdrr.io/r/utils/write.table.html),
  [`utils::write.csv2`](https://rdrr.io/r/utils/write.table.html),
  [`utils::write.table`](https://rdrr.io/r/utils/write.table.html),
  [`foreign::read.spss`](https://rdrr.io/pkg/foreign/man/read.spss.html),
  `sjlabelled::write_spss`

- filename:

  File name of `BIFIEdata` object

- files.imp:

  Vector of file names of imputed datasets

- wgt:

  Variable name of case weight

- file.wgtrep:

  File name for dataset with replicate weights

- file.ind:

  Optional. File name for dataset with response data indicators

## Value

Saved R object and a summary in working directory or a loaded R object.

## See also

For creating objects of class `BIFIEdata` see
[`BIFIE.data`](https://konradoberwimmer.github.io/BIFIEsurvey/reference/BIFIE.data.md).

[`base::save`](https://rdrr.io/r/base/save.html),
[`base::load`](https://rdrr.io/r/base/load.html)

## Examples

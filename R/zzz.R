## File Name: zzz.R
## File Version: 0.14
#  zzz.R
#
# This function is simply copied from mice package.


# on attach
.onAttach <- function(libname,pkgname)
{
    if (getOption("BIFIEsurvey.quiet", default = FALSE)) {
      return()
    }
  
    d <- utils::packageDescription("BIFIEsurvey")
    packageStartupMessage("|---------------------------------------------------------",
                "--------\n",
                paste("| ",d$Package," ", d$Version," (",d$Date,")",sep=""),
                "\n| http://www.iqs.gv.at                                             ",
                "\n|---------------------------------------------------",
                "--------------\n" )
}

version <- function(pkg="BIFIEsurvey")
{
    lib <- dirname( system.file(package=pkg) )
    d <- utils::packageDescription(pkg)
    return( paste(d$Package,d$Version,d$Date,lib) )
}

prepareConsoleProgressBar <- function(numberOfImputations) {
  if (getOption("BIFIEsurvey.quiet", default = FALSE)) {
    return()
  }
  
  cat(paste0( "|", paste0( rep("*", numberOfImputations), collapse=""), "|\n" ))
}

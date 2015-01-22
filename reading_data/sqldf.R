MeanProbabilityWeightBelowAge50 <- function(downloadData=TRUE) {
  # Downloads a csv file from the The American Community Survey's 2006 microdata
  # survey about housing for Idaho and reads the file to a data frame.
  # Returns the mean probability weight with ages less than 50.
  #
  # Args:
  #   downloadData: determines whether the data (and codebook) should be
  #     downloaded, use false if you have previously downloaded the data
  #
  # Returns:
  #   A numeric representing the mean probability weight with ages less
  #   than 50.

  library(sqldf)
  source("reading_data/utilities.R")

  # The American Community Survey distributes downloadable data about United
  # States communities. Download the 2006 microdata survey about housing for the
  # state of Idaho
  fileDataUrl <- paste("https://d396qusza40orc.cloudfront.net/",
                       "getdata%2Fdata%2Fss06pid.csv",
                       sep="")
  fileDataDest <- "getdata-data-ss06pid.csv"
  fileDataDest <- DownloadDataFromUrl(fileDataUrl, fileDataDest, downloadData)

  dfHousing <- read.csv(fileDataDest)

  # Execute our SQL command on the data frame and calculate the mean
  dfProbabilityWeight <- sqldf("select pwgtp1 from dfHousing where AGEP < 50")
  meanPwgtp1 <- lapply(dfProbabilityWeight, mean)
  return(meanPwgtp1[[1]])
}

MeanPersonWeightReplicate15Idaho <- function(downloadData=TRUE) {
  # Downloads a file from The American Community Survey's 2006 microdata survey
  # about housing for Idaho and reads the file to a data table.
  # Returns the mean person weight replicate 15 segmented by sex.
  #
  # Args:
  #   downloadData: determines whether the data (and codebook) should be
  #     downloaded, use false if you have previously downloaded the data
  #
  # Returns:
  #   An integer vector containing the number of million dollar homes in Idaho

  library(data.table)
  source("reading_data/utilities.R")

  # The American Community Survey distributes downloadable data about United
  # States communities. Download the 2006 microdata survey about housing for the
  # state of Idaho
  fileDataUrl <- paste("https://d396qusza40orc.cloudfront.net/",
                       "getdata%2Fdata%2Fss06pid.csv",
                       sep="")
  fileDataDest <- "getdata-data-restaurants.xml"
  fileDataDest <- DownloadDataFromUrl(fileDataUrl, fileDataDest, downloadData)

  dtHousing <- fread(fileDataDest)

  # Calculate the average value of the variable pwgtp15 broken down by sex
  # using the data.table package
  # From the codebook:
  # PWGTP15 Person's Weight replicate 15
  # 0001..9999 .Integer weight of person
  meanPwgtp15 <- sapply(split(dtHousing$pwgtp15, dtHousing$SEX), mean)
  return(meanPwgtp15)
}

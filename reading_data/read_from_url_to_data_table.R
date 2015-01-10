ReadFromUrlToDataTable <- function(fileDataUrl,
                                   fileDataDest,
                                   downloadData=TRUE) {
  # Downloads a file from the given url and reads the file to a data table.
  #
  # Returns the mean person weight replicate 15 segmented by sex from the
  # The American Community Survey's 2006 microdata survey about housing for
  # Idaho
  #
  # Args:
  #   fileDataUrl: the url containing the data file
  #   fileDataDest: the file name that will contain the data from the url
  #     file will be placed in the data directory
  #   downloadData: determines whether the data (and codebook) should be
  #     downloaded, use false if you have previously downloaded the data
  #
  # Returns:
  #   An integer vector containing the number of million dollar homes in Idaho

  library(data.table)
  source("download_data_from_url.r")

  DownloadDataFromUrl(fileDataUrl, fileDataDest, downloadData)

  dt <- fread(fileDataDest)

  # Calculate the average value of the variable pwgtp15 broken down by sex
  # using the data.table package
  # From the codebook:
  # PWGTP15 Person's Weight replicate 15
  # 0001..9999 .Integer weight of person
  meanPwgtp15 <- sapply(split(DT$pwgtp15, DT$SEX), mean)
  return(meanPwgtp15)
}

# Tests
# The American Community Survey distributes downloadable data about United
# States communities. Download the 2006 microdata survey about housing for the
# state of Idaho
fileDataUrl <- paste("https://d396qusza40orc.cloudfront.net/",
                     "getdata%2Fdata%2Fss06pid.csv",
                     sep="")
fileDataDest <- paste(dataDir,
                      "getdata-data-restaurants.xml",
                      sep="")
ReadFromUrlToDataTable(fileDataUrl, fileDataDest)
# 1        2
# 99.80667 96.66534

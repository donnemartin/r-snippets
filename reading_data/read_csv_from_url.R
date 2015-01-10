ReadCsvFromUrl <- function(fileDataUrl, fileDataDest, downloadData=TRUE) {
  # Downloads a csv file from the given url and saves it to the given
  # destination.  Reads the downloaded file to a data frame.
  #
  # Returns the number of million dollar homes in Idaho based on
  # The American Community Survey's 2006 microdata on Idaho.
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

  source("download_data_from_url.r")

  DownloadDataFromUrl(fileDataUrl, fileDataDest, downloadData)

  dfHousing <- read.csv(fileDataDest)

  # Determine how many homes are worth a million dollars or more
  # From the codebook located at:
  # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
  # VAL Property value
  # 02 .$ 10000 - $ 14999
  # 03 .$ 15000 - $ 19999
  # ...
  # 23 .$750000 - $999999
  # 24 .$1000000+
  kMillionDollarValue <- 24
  numMillionDollarHomes <- nrow(subset(dfHousing, VAL == kMillionDollarValue))
}

# Tests
# The American Community Survey distributes downloadable data about United
# States communities. Download the 2006 microdata survey about housing for the
# state of Idaho
fileDataUrl <- paste("https://d396qusza40orc.cloudfront.net/",
                     "getdata%2Fdata%2Fss06hid.csv",
                     sep="")
fileDataDest <- paste(dataDir,
                      "getdata-data-ss06hid.csv",
                      sep="")
ReadCsvFromUrl(fileDataUrl, fileDataDest)
# [1] 53

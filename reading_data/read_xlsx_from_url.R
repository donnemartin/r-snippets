ReadXlsxFromUrl <- function(fileDataUrl, fileDataDest, downloadData=TRUE) {
  # Downloads an xlsx file from the given url and saves it to the given
  # destination.  Reads selected rows and columns from the downloaded file
  # to a data frame.
  #
  # Returns the contractor city and zip from xlsx data on the Natural Gas
  # Aquisition Program.
  #
  # Args:
  #   fileDataUrl: the url containing the data file
  #   fileDataDest: the file name that will contain the data from the url
  #     file will be placed in the data directory
  #   downloadData: determines whether the data should be
  #     downloaded, use false if you have previously downloaded the data
  #
  # Returns:
  #   A data frame containing the contractors city and zip

  library(xlsx)
  source("download_data_from_url.r")

  DownloadDataFromUrl(fileDataUrl, fileDataDest, downloadData)

  # Read only the contractor address info cells
  contractorTableRowRange <- 18:23
  cityZipRange <- 6:7

  dfGas <- read.xlsx(fileDataDest,
                     sheetIndex=1,
                     rowIndex=contractorTableRowRange,
                     colIndex=cityZipRange)

  return(dfGas)
}

# Tests
# Original data source:
# http://catalog.data.gov/dataset/natural-gas-acquisition-program
fileDataUrl <- paste("https://d396qusza40orc.cloudfront.net/",
                     "getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
                     sep="")
fileDataDest <- paste(dataDir,
                      "getdata-data-DATA.gov_NGAP.xlsx",
                      sep="")
ReadXlsxFromUrl(fileDataUrl, fileDataDest)
#        City   Zip
# 1     Tulsa 74136
# 2   Atlanta 30329
# 3     Tulsa 74136
# 4    Denver 80203
# 5 Littleton 80120
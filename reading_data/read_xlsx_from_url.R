ListGasContractorsCityZip <- function(downloadData=TRUE) {
  # Downloads an xlsx file from the the Natural Gas Aquisition Program.
  # Reads selected rows and columns from the downloaded file to a data frame.
  # Returns the contractor city and zip.
  #
  # Args:
  #   downloadData: determines whether the data should be
  #     downloaded, use false if you have previously downloaded the data
  #
  # Returns:
  #   A data frame containing the contractors city and zip

  library(xlsx)
  source("reading_data/utilities.R")

  # Original data source:
  # http://catalog.data.gov/dataset/natural-gas-acquisition-program
  fileDataUrl <- paste("https://d396qusza40orc.cloudfront.net/",
                       "getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
                       sep="")
  fileDataDest <- "getdata-data-DATA.gov_NGAP.xlsx"
  fileDataDest <- DownloadDataFromUrl(fileDataUrl, fileDataDest, downloadData)

  # Read only the contractor address info cells
  sheetIndex <- 1
  contractorTableRowRange <- 18:23
  cityZipColRange <- 6:7

  dfCityZip <- read.xlsx(fileDataDest,
                         sheetIndex=sheetIndex,
                         rowIndex=contractorTableRowRange,
                         colIndex=cityZipColRange)
  return(dfCityZip)
}

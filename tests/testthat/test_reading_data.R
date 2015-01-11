context("Reading Data")

setwd("../../")
source("reading_data/utilities.R")

GetDataDir <- function() {
  # Returns the data directory file path.
  #
  # Args:
  #   none
  #
  # Returns:
  #   The data directory file path
  return("data/")
}

DownloadData <- function() {
  # Determines whether to download the data files.  Set return value to FALSE
  # to speed up running the unit tests.
  #
  # Args:
  #   none
  #
  # Returns:
  #   TRUE: Download the data files
  #   FALSE: Do not download the data files, use the already existing data file
  #     if it exists.  Note: Does not check whether existing data file already
  #     exists.
  return(FALSE)
}

test_that("data directory is created", {
  SetupDataDir(GetDataDir())
  expect_true(file.exists(GetDataDir()))
})

test_that("data is downloaded from URL", {
  fileDataUrl <- paste("https://d396qusza40orc.cloudfront.net/",
                       "getdata%2Fdata%2Frestaurants.xml",
                       sep="")
  fileDataDest <- "getdata-data-restaurants.xml"
  fileDataDest <- DownloadDataFromUrl(fileDataUrl,
                                      fileDataDest,
                                      downloadData=DownloadData())
  expect_true(file.exists(fileDataDest))
})

test_that("data on number of million dollar homes is read from csv", {
  result <- NumMillionDollarHomesIdaho(DownloadData())
  baseline <- 53
  expect_equal(result[1], baseline)
})

test_that("data on gas contractor city and zip is read from xlsx", {
  result <- ListGasContractorsCityZip(DownloadData())

  # Generate our baseline data frame to match against our result
  city <- c("Tulsa", "Atlanta", "Tulsa", "Denver", "Littleton")
  zip <- c(74136, 30329, 74136, 80203, 80120)
  baseline <- data.frame(city, zip)

  # Match up the column names
  colnames(baseline) <- c("City", "Zip")

  expect_equal(result, baseline)
})

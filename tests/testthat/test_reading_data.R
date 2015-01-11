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
  return(TRUE)
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

test_that("data is read from csv", {
  # Tests
  # The American Community Survey distributes downloadable data about United
  # States communities. Download the 2006 microdata survey about housing for the
  # state of Idaho
  fileDataUrl <- paste("https://d396qusza40orc.cloudfront.net/",
                       "getdata%2Fdata%2Fss06hid.csv",
                       sep="")
  fileDataDest <- "getdata-data-ss06hid.csv"
  result <- ReadCsvFromUrl(fileDataUrl,
                           fileDataDest,
                           downloadData=DownloadData())
  expect_equal(result[1], 53)
})

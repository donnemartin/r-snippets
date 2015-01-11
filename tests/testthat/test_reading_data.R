context("Reading Data")

source("../../reading_data/utilities.R")

getDataDir <- function() {
  return("../../data")
}

test_that("data directory is created", {
  SetupDataDir(getDataDir())
  expect_true(file.exists(getDataDir()))
})

test_that("data downloaded from URL", {
  fileDataUrl <- paste("https://d396qusza40orc.cloudfront.net/",
                       "getdata%2Fdata%2Frestaurants.xml",
                       sep="")
  fileDataDest <- "getdata-data-restaurants.xml"
  fileDataDest <- DownloadDataFromUrl(fileDataUrl,
                                      fileDataDest,
                                      downloadData=TRUE)
  expect_true(file.exists(fileDataDest))
})
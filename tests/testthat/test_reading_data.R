# Run with devtools::test()
context("Reading Data")

# test_that does a good job ensuring that each test is run in its own
# environment and is self-contained.
#
# The test_that documentation lists the following as an exception:
# The filesystem: creating and deleting files, changing the working directory
#
# Because we are using data files and setting a new working directory, we must
# save the current working directory here and restore it at the end of our
# tests.
prevWorkingDir <- getwd()
setwd("../../")
source("reading_data/utilities.R")
sourceDir("reading_data/")

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
  if (DownloadData()) {
    fileDataUrl <- paste("https://raw.githubusercontent.com/donnemartin/",
                         "donnemartin.github.io/master/images/profile.png",
                         sep="")
    fileDataDest <- "profile.png"
    fileDataDest <- DownloadDataFromUrl(fileDataUrl,
                                        fileDataDest,
                                        downloadData=DownloadData())
    expect_true(file.exists(fileDataDest))
  }
  else {
    skip("skipped downloading data to speed up tests")
  }
})

test_that("data on number of million dollar homes is read from csv", {
  result <- NumMillionDollarHomesIdaho(DownloadData())
  baseline <- 53
  expect_equal(result, baseline)
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

test_that("data on number of baltimore restaurants by zip is read from xml", {
  result <- NumBaltimoreRestaurantsInZip(21217, DownloadData())
  baseline <- 32
  expect_equal(result, baseline)
})

test_that("data on mean person weight replicate 15 is read from data table", {
  result <- MeanPersonWeightReplicate15Idaho(DownloadData())
  baseline <- c(99.80667, 96.66534)
  names(baseline) <- c("1", "2")
  tolerance <- 10
  expect_equal(result, baseline, tolerance)
})

test_that("data on r-snippets creation date is read from json", {
  result <- RSnippetsCreatedAt()
  baseline <- "2015-01-09T18:24:19Z"
  expect_equal(result, baseline)
})

test_that("data on mean person weight replicate 1 is read using sqldf", {
  result <- MeanProbabilityWeightBelowAge50(DownloadData())
  baseline <- 103.8886
  tolerance <- 10
  expect_equal(result, baseline, tolerance)
})

test_that("data on sum of chars on personal website is read using readLines", {
  result <- SumCharsPersonalWebsite()
  baseline <- 153956
  tolerance <- 10
  expect_equal(result, baseline, tolerance)
})

# Restore the previous working directory
setwd(prevWorkingDir)
DownloadDataFromUrl <- function(fileDataUrl, fileDataDest, downloadData=TRUE) {
  # Downloads the specified file from the given url and saves it to the
  # given file destination
  #
  # Args:
  #   fileDataUrl: the url containing the data file
  #   fileDataDest: the file name that will contain the data from the url
  #     file will be placed in the data directory
  #   downloadData: determines whether the data (and codebook) should be
  #     downloaded, use false if you have previously downloaded the data
  #
  # Returns:
  #   The file data destination path in the data directory

  dataDir <- "data/"
  SetupDataDir(dataDir)

  fileDataDest <- paste(dataDir, fileDataDest, sep="")

  if (downloadData) {
    download.file(fileDataUrl, destfile=fileDataDest, method="curl")
  }

  return(fileDataDest)
}

SetupDataDir <- function(dataDir) {
  # Creates the data directory if it doesn't already exist.
  #
  # Args:
  #   dataDir: the data directory name
  #
  # Returns:
  #   None

  if (!file.exists(dataDir)) {
    dir.create(dataDir)
  }
}
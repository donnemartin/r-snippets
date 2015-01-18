NumBaltimoreRestaurantsInZip <- function(zip, downloadData=TRUE) {
  # Downloads an xml file from the Baltimore restaurants data set.
  # Reads the downloaded file with xmlTreeParse and uses XPATH
  # to filter values.
  # Returns the number of Baltimore restaurants in the given zip.
  #
  # Args:
  #   zip: the Baltimore zip code to search for restaurants
  #   downloadData: determines whether the data should be
  #     downloaded, use false if you have previously downloaded the data
  #
  # Returns:
  #   An integer vector containing the number of restaurants in the given zip

  library(XML)
  source("reading_data/utilities.R")

  fileDataUrl <- paste("https://d396qusza40orc.cloudfront.net/",
                       "getdata%2Fdata%2Frestaurants.xml",
                       sep="")
  fileDataDest <- paste("getdata-data-restaurants.xml")
  fileDataDest <- DownloadDataFromUrl(fileDataUrl, fileDataDest, downloadData)

  # Can also download from the URL directly with xmlTreeParse
  doc <- xmlTreeParse(fileDataDest, useInternal=TRUE)
  rootNode <- xmlRoot(doc)

  # Generate the XPATH expression to filter "zipcode" xml elements that have
  # the given zipcode value
  expression <- paste("//row/zipcode[text()=",
                      zip,
                      "]",
                      sep="")

  # Get the nodes matching the XPATH expression
  nodes <- getNodeSet(rootNode, expression)
  return(length(nodes))
}

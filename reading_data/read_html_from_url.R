SumCharsPersonalWebsite <- function() {
  # Reads html from a website line by line
  # Returns the number of characters read
  #
  # Args:
  #   none
  #
  # Returns:
  #   A numeric representing the number of characters read

  url <- "http://donnemartin.com"

  connection <- url(url)
  htmlCode <- readLines(connection)
  close(connection)

  sumChars <- sum(nchar(htmlCode))
  return(sumChars)
}

RSnippetsCreatedAt <- function() {
  # Reads JSON data from GitHub API.
  # Returns the repo creation date field "created_at"
  #
  # Args:
  #   none
  #
  # Returns:
  #   A character vector representing the R Snippet's repo creation date

  library(jsonlite)

  # Get the list of repos for a specific user and load the data to JSON
  url <- "https://api.github.com/users/donnemartin/repos"
  jsonData <- fromJSON(url)

  # Extract the "created_at" field
  repoNameKey <- "r-snippets"
  repoCreateDateKey <- "created_at"
  jsonData <- subset(jsonData, name==repoNameKey)
  return(jsonData$created_at)
}
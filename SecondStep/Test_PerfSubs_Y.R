library("exams")

setwd('/Users/SHSU/R_work/NAREA/SecondStep/')

#generateRandomDataFrame <- function(n = 1) {
#  py <- sample(5:50, n, replace = TRUE)
#  px <- sample(5:50, n, replace = TRUE)
#  r <- sample(5:50, n, replace = TRUE)
#  d <- sample(5:50, n, replace = TRUE)
#  I <- sample(1000:2000, n, replace = TRUE)
#  
#  df <- data.frame(py, px, r, d, I)
#  
#  return(df)
#}

generateRandomDataFrame <- function(n = 1000) {  # Set a higher initial n to account for filtering out
  df <- data.frame(
    px = sample(5:50, n, replace = TRUE),
    py = sample(5:50, n, replace = TRUE),
    r = sample(5:100, n, replace = TRUE),
    d = sample(5:100, n, replace = TRUE),
    I = sample(1000:4000, n, replace = TRUE)
  )
  
  # Filter rows where r/d != px/py
  df <- df[with(df, r/d != px/py), ]
  
  # If after filtering, the dataframe has more rows than requested, truncate it
  if(nrow(df) > n) {
    df <- df[1:n, ]
  }
  
  return(df)
}


set.seed(123)
randomDataFrame <- generateRandomDataFrame(5)

# Define the processMarkdown function
processMarkdown <- function(py, px, r, d, I, counter) {
  # Read the markdown template
  template_path <- "/Users/SHSU/R_work/NAREA/SecondStep/PerfectSubs_Y_Template_Food.Rmd"
  template_text <- readLines(template_path, warn = FALSE)
  
  # Replace placeholders with actual values
  processed_text <- gsub("\\{py\\}", py, template_text)
  processed_text <- gsub("\\{px\\}", px, processed_text)
  processed_text <- gsub("\\{r\\}", r, processed_text)
  processed_text <- gsub("\\{d\\}", d, processed_text)
  processed_text <- gsub("\\{I\\}", I, processed_text)
  
  # New part: Substitute variable x with a random food item
  food_items <- c("Doritos", "Nutella", "Tamales", "Chesters", "Beef", "Nachos", "Almonds", "Funyuns")
  x_random <- sample(food_items, 1)  # Get one random element from the vector
  processed_text <- gsub("\\{x\\}", x_random, processed_text)  # Substitute {x} with the random element
  
  # New part: Substitute variable x with a random food item
  food_items_two <- c("Cheetos", "Popcorn", "Brisket", "Pringles", "Ruffles", "Takis", "Peanuts", "Fritos")
  y_random <- sample(food_items_two, 1)  # Get one random element from the vector
  processed_text <- gsub("\\{y\\}", y_random, processed_text)  # Substitute {y} with the random element
  
  # Generate a unique file name for the output
  output_file_name <- sprintf("PerfSub_food_numeric_%d.Rmd", counter)
  
  # Save the processed markdown to a new file
  writeLines(processed_text, output_file_name)
  
  # Return the path of the newly saved file
  return(output_file_name)
}

# Initialize the counter
counter_next <- 1

# Call processMarkdown for each row in the data frame
output_files <- lapply(1:nrow(randomDataFrame), function(i) {
  output_file_path <- with(randomDataFrame[i, ], processMarkdown(py, px, r, d, I, counter_next))
  counter_next <<- counter_next + 1  # Update counter; use '<<-' for global assignment within function
  return(output_file_path)
})

# Now calculate the total number of files created
totfile <- length(output_files)  # This should now reflect the actual number of files created

# Create an object with all filenames
# Create a matrix of filenames using a different naming convention
exm <- cbind(sapply(1:totfile, function(i) paste0("PerfSub_food_numeric_", i, ".Rmd")))

# Before calling exams2blackboard, ensure exm contains the correct file paths
exams2blackboard(exm, name="perfect_substitutes_y_food")

# Optionally, delete the files
#for(file_name in exm) { 
#  if(file.exists(file_name)) {
#    file.remove(file_name)
#  }
#}

library("exams")

setwd('/Users/SHSU/R_work/NAREA/SecondStep/')

generateRandomDataFrame <- function(n = 1000) {
  library(dplyr)  # Ensure dplyr is loaded for filtering
  
  # Create the data frame without unnecessary variable assignments
  df <- data.frame(
    a = sample(seq(1, 20, by = 0.2), n, replace = TRUE),
    c = sample(seq(1, 20, by = 0.2), n, replace = TRUE),
    b = sample(250:2000, n, replace = TRUE),
    f = sample(5:50, n, replace = TRUE)
  )
  
  # Filter rows using dplyr's filter function
#  filtered_df <- df %>%
  #  filter((f / c) > 0.1 * (b / a) & (f / c) < 0.6 * (b / a))
 #   filter((f / c) < 0.2 * (b / a))
    
  # Print the filtered data frame
  print(df)
  
  return(df)
}


set.seed(123)
randomDataFrame <- generateRandomDataFrame(3)

# Define the processMarkdown function
processMarkdown <- function(a, b, c, f, counter) {
  # Read the markdown template
  template_path <- "/Users/SHSU/R_work/NAREA/SecondStep/SandD_Equilibrium_Q_Food_V2.Rmd"
  template_text <- readLines(template_path, warn = FALSE)
  
  # Replace placeholders with actual values
  processed_text <- gsub("\\{a\\}", a, template_text)
  processed_text <- gsub("\\{b\\}", b, processed_text)
  processed_text <- gsub("\\{c\\}", c, processed_text)
  processed_text <- gsub("\\{f\\}", f, processed_text)
  
  # New part: Substitute variable x with a random food item
  food_items <- c("Pizza", "Tacos", "Sneakers", "Books", "Cars", "Water", "Hot Cheetos", "Trucks", 
                  "Candles", "Sunglasses", "Beer", "Tequila", "Rum", "Limes")
  good <- sample(food_items, 1)  # Get one random element from the vector
  processed_text <- gsub("\\{good\\}", good, processed_text)  # Substitute {x} with the random element
  
  # New part: Substitute variable x with a random food item
# food_items_two <- c("Cheetos", "Popcorn", "Brisket", "Pringles", "Ruffles", "Takis", "Peanuts", "Fritos")
#  y_random <- sample(food_items_two, 1)  # Get one random element from the vector
#  processed_text <- gsub("\\{y\\}", y_random, processed_text)  # Substitute {y} with the random element
  
  # Generate a unique file name for the output
  output_file_name <- sprintf("SandD_quantity_food_numeric_%d.Rmd", counter)
  
  # Save the processed markdown to a new file
  writeLines(processed_text, output_file_name)
  
  # Return the path of the newly saved file
  return(output_file_name)
}

# Initialize the counter
counter_next <- 1

# Call processMarkdown for each row in the data frame
output_files <- lapply(1:nrow(randomDataFrame), function(i) {
  output_file_path <- with(randomDataFrame[i, ], processMarkdown(a, b, c, f, counter_next))
  counter_next <<- counter_next + 1  # Update counter; use '<<-' for global assignment within function
  return(output_file_path)
})

# Now calculate the total number of files created
totfile <- length(output_files)  # This should now reflect the actual number of files created

# Create an object with all filenames
# Create a matrix of filenames using a different naming convention
exm <- cbind(sapply(1:totfile, function(i) paste0("SandD_quantity_food_numeric_", i, ".Rmd")))

# Before calling exams2blackboard, ensure exm contains the correct file paths
exams2blackboard(exm, name="SandD_quantity_food_V2")

# Optionally, delete the files
#for(file_name in exm) {
#  if(file.exists(file_name)) {
#    file.remove(file_name)
#  }
#}

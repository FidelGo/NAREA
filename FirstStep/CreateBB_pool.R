# Creates a very simpple two question pdf exam

# This is needed to create the exam
library(exams)

# Change the command below to your working directory: change this to the path on your computer where
# you have the rmd and the rscript folder

working_dir <- '/Users/SHSU/R_work/NAREA/FirstStep/'

# Set the working adirectory
setwd(working_dir)

# Define the list of question files (ensure these files exist in the working directory)

myexam <- cbind(c(
  "cs_benefit_1.Rmd",
  "cs_benefit_2.Rmd")
)

# Assuming you are using BB 
exams2blackboard(myexam, name="delete_pool")

# If you are not using BB then comment the line above and uncomment the line
# below that corresponds to your LM

## For canvas (the result would be a QTI Zip file to import into canvas)
#exams2canvas(myexam, name = "delete_pool")

## For Moodle (the result would be a XML file to import into moodle)
#exams2moodle(myexam, name = "delete_pool")

## For OLAT (the result would be a zip file to import into moodle)
#exams2olat(myexam, name = "delete_pool")

## For systems supporting QTI 1.2 (older LMS versions), create a zip file
# exams2qti12(myexam, name = "delete_pool")

## To print a pdf file 
#exams2pdf(myexam, name = "delete_pool")

# Print a success message
cat("Blackboard exam pool generated successfully.\n")
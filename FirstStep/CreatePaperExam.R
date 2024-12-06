# Creates a very simpple two question pdf exam

# This is needed to create the exam
library(exams)

# Change the command below to your working directory: change this to the path on your computer where
# you have the rmd and the rscript folder

working_dir <- '/Users/SHSU/R_work/NAREA/FirstStep/'

# Set the working directory
setwd(working_dir)

# Have a very simplte two question pdf exam
myexam <- list("cs_benefit_1.Rmd", "cs_benefit_2.Rmd", "Topic_4_MC_1.Rmd", "SE_MC_symbolic_1.Rmd")


# Define the list of question files
#myexam <- list(
#  c("cs_benefit_1.Rmd", "question2.Rmd", "question3.Rmd"), # Randomly select one
#  "question4.Rmd",                                       # Always include this question
#  c("question5.Rmd", "question6.Rmd")                    # Randomly select one
#)

# Generate a PDF exam
# n specifies the number of different versions of the exam to generate
# name specifies the prefix for the output files
exams2pdf(
  myexam,
  n = 1,                  # Number of exam versions
  name = "exam",          # Output file prefix
  template = "exam.tex"   # Optional: specify a LaTeX template (default template if omitted)
)

# Print a success message
cat("Exam PDF generated successfully.\n")
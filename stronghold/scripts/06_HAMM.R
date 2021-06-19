suppressMessages(library(readr))
suppressMessages(library(here))
args = commandArgs(trailingOnly=TRUE)

strings <- read_file(args[1])

strings <- unlist(strsplit(strings, '\n'))

seq_a <- unlist(strsplit(strings[1], ''))
seq_b <- unlist(strsplit(strings[2], ''))

differences <- sum(seq_a != seq_b)

print(differences)

write_file(as.character(differences), here('output', '06_HAMM.txt'))


library(tidyverse)
args = commandArgs(trailingOnly=TRUE)

dna_string <- read_file(args[1])

# sample_dataset 
# dna_string <- 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'

dna_count <- dna_string %>%
  str_count(c('A', 'C', 'G', 'T')) %>% 
  paste0(collapse = ' ')

print(dna_count)

write_file(dna_count, './output/01_DNA.txt')

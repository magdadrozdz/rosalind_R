library(stringr)
library(readr)
library(here)
args = commandArgs(trailingOnly=TRUE)

dna_string <- read_file(args[1])

# sample_dataset 
# dna_string <- 'GATGGAACTTGACTACGTAAATT'

rna_string <- str_replace_all(dna_string, 'T', 'U')

print(rna_string)

write_file(rna_string, here('output', '02_RNA.txt'))

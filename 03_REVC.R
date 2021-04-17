suppressMessages(library(readr))
suppressMessages(library(magrittr))
suppressMessages(library(Biostrings))
args = commandArgs(trailingOnly=TRUE)

dna_string <- read_file(args[1])

# sample_data
# dna_string <- 'AAAACCCGGT'

rev_complement <- dna_string %>%
  trimws() %>%
  DNAString() %>% 
  reverseComplement() %>%
  as.character() %>%
  paste0(collapse = ' ')
  
print(rev_complement)

write_file(rev_complement, './output/03_REVC.txt')
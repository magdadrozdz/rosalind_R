suppressMessages(library(readr))
suppressMessages(library(magrittr))
suppressMessages(library(Biostrings))
library(here)
args = commandArgs(trailingOnly=TRUE)

rna_string <- read_file(args[1])

# sample_data
#rna_string <- 'AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA'

protein <- rna_string %>%
  trimws() %>%
  RNAString() %>% 
  translate(no.init.codon = T) %>%
  as.character() %>%
  substr(1,nchar(.)-1)

print(protein)

write_file(protein, here('output', '07_PROT.txt'))

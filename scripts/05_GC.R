suppressMessages(library(tidyverse))
suppressMessages(library(here))
suppressMessages(library(Biostrings))
args = commandArgs(trailingOnly=TRUE)

dna_string <- readDNAStringSet(args[1])

#dna_string <- readDNAStringSet(here('input', 'rosalind_gc.txt'))

top_count <- alphabetFrequency(dna_string, baseOnly=T, collapse=F) %>% 
  data.frame() %>% 
  rowwise() %>%
  mutate(GC_content = sprintf("%0.6f", sum(C,G)/sum(A, C, `T`, G)*100)) %>%
  ungroup() %>%
  rowid_to_column(var = 'row_id') %>%
  top_n(1) %>% 
  select(row_id, GC_content)

result <- paste0(names(dna_string[top_count$row_id,]), top_count$GC_content, sep ='\n')

cat(result)

write_file(result, here('output', '05_GC.txt'))

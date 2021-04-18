suppressMessages(library(tidyverse))
suppressMessages(library(here))
suppressMessages(library(stringi))
args = commandArgs(trailingOnly=TRUE)

input <- read_file(args[1]) %>%
  str_split('\n', simplify = T) 

dna_string <- input[1]
motif <- input[2]

# exapmle data 
# dna_string <- 'GATATATGCATATACTT'
# motif <- 'ATAT'

locations <- stri_locate_all_regex(dna_string, paste0("(?=", motif, ")")) %>% 
  data.frame() %>% 
  select(start) %>% 
  pull() %>% 
  paste0(collapse = ' ')

print(locations)

write_file(locations, here('output', '08_SUBS.txt'))


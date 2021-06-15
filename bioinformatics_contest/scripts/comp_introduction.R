suppressMessages(library(tidyverse))
suppressMessages(library(here))
suppressMessages(library(stringi))

vals <- read_delim(here('input', 'comp_input_a.txt'), delim = ' ', skip = 1, col_names = c('val1', 'val2'))

sums <- vals %>% 
  rowwise() %>% 
  mutate(sum = sum(val1, val2)) %>% 
  pull(sum) %>% 
  tibble()

write_delim(sums, here('output', 'comp_output_a.txt'), col_names = F)

#### Problem B ####

input <- read_file(here('input', 'comp_input_b.txt')) %>%
  str_split('\n', simplify = T) 

input <- read_delim(here('input', 'comp_input_b.txt'), delim = '\n', col_names = F, skip = 1)

strings <- input[seq(from = 1, to = nrow(input), by = 2),]
motifs <-  input[seq(from = 2, to = nrow(input), by = 2),]

dt <- bind_cols(strings, motifs) %>%
  rename(string = 'X1...1', motif = 'X1...2')

# exapmle data 
# dna_string <- 'GATATATGCATATACTT'
# motif <- 'ATAT'


sink(here('output', 'comp_output_b.txt'))

for (i in 1:nrow(dt)){

string <- dt[i,1]
motif <- dt[i,2]

result <- stri_locate_all_regex(string, paste0("(?=", motif, ")")) %>% 
  data.frame() %>% 
  select(start) %>% 
  pull() %>% 
  paste0(collapse = ' ') %>% 
  paste0(., '\n')

cat(result)
}

sink()





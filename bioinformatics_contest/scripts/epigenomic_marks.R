suppressMessages(library(tidyverse))
suppressMessages(library(here))
suppressMessages(library(stringi))

get_vector <- function(sequence_vector, seq_locs) {
  res <- c()
  gr <- seq_locs[which(seq_locs$seqs == sequence_vector), 'group']
  res <- c(res, gr)
  return(res)}


input <- read_file(here('bioinformatics_contest', 'input', 'epigenomic_marks_1.txt')) %>%
  str_split('\n', simplify = T) 

# remove info about test number
n_tests <- input[1]
input <- input[-1]

# find the locations of info segments
info_locations <- which(str_detect(input, ' ') == TRUE)

splitAt <- function(x, pos) unname(split(x, cumsum(seq_along(x) %in% pos)))

string_list <- splitAt(input, info_locations)


sink(here('bioinformatics_contest', 'output', 'epigenomic_marks_1.txt'))

for (l in 1:length(string_list)){
  
  # extract one list
  split_list <- str_split(string_list[[l]][2:length(string_list[[l]])], '')
  
  # extract the sequences
  seqs <- c()
  for (i in 1:length(split_list[[1]])) {
    
    motif <- split_list %>%
      map_chr(., i) %>% 
      paste0(collapse = '')
    
    seqs <- c(seqs, motif)}
  
  seq_locations <- tibble(seqs = unique(seqs), group = seq(1:length(unique(seqs))))

  res <- sapply(seqs, get_vector, seq_locs = seq_locations)
  
  # print result to file 
  res %>% unique() %>% length() %>% paste0(., '\n') %>% cat()
  res %>% paste(., collapse = ' ') %>% paste0(., '\n') %>% cat()
}

sink()










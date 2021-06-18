# Given: A collection of k (k≤100) DNA strings of length at 
# most 1 kbp each in FASTA format.

# Return: A longest common substring of the collection. 
# (If multiple solutions exist, you may return any single solution.)

# Sample Dataset
# >Rosalind_1
# GATTACA
# >Rosalind_2
# TAGACCA
# >Rosalind_3
# ATACA

# Sample Output
# CA

suppressMessages(library(tidyverse))
suppressMessages(library(here))
suppressMessages(library(Biostrings))
suppressMessages(library(stringi))
args = commandArgs(trailingOnly=TRUE) 

Any <- function(x, sf) {
  if (sum(!is.na(str_locate(sf, x))) > 1){TRUE}
  else FALSE}

lcs <- function(data) {
  min_str <- data[which.min(sapply(data, nchar))]
  min_len <- nchar(min_str)
  bl <- character() # blacklist
  result <- NULL
  ofs <- 0
  
  for (i in 1:min_len) {
    last_result <- result
    
    for (j in (1+ofs):(min_len - i + 1)) {
      search_for <- substr(min_str, j, j+i-1)

      if (Any(bl, search_for)) next
      
      abort <- FALSE
      for (k in data) {
        if (is.na(str_locate(k, search_for)[1,1])) {
          bl <- cbind(bl, search_for)
          abort <- TRUE
          break}
          }
      
      if (abort) next
      ofs <- j-1 # No bigger string was found before this offset
      result <- search_for
      break
    }
    
    if (!is.null(last_result) && last_result == result) break
  }
  result
}

dna_strings <- readDNAStringSet(args[1]) %>% as.character()
sink(here('output', '09_LCSM.txt'))
cat(lcs(dna_strings))
sink()


suppressMessages(library(tidyverse))
suppressMessages(library(here))
suppressMessages(library(stringi))
library(data.table)
library(gtools)
library(glue)

get_smallest <- function(matrix, n){
  res <- which(abs(matrix - n)  == min(abs(matrix - n), na.rm = T), arr.ind = T)[1,]
  paste0(res['row'], ' ', res['col'], '\n') %>% cat() }

test_number <- 3

input <- read_file(here('bioinformatics_contest', 'input', glue('metabolite_annotation_{test_number}.txt'))) %>%
  str_split("[\r][\n]", simplify = T) %>% 
  trimws()

# remove info about test number
n_tests <- input[1]
input <- input[-1]

# find the locations of info segments
info_locations <- which(str_detect(input, '[0-9]{2,6}\ [0-9]{2,6}\ [0-9]{2,6}') == TRUE)

splitAt <- function(x, pos) unname(split(x, cumsum(seq_along(x) %in% pos)))

string_list <- splitAt(input, info_locations)

start_time <- Sys.time()

sink(here('bioinformatics_contest', 'output', glue('metabolite_annotation_{test_number}.txt')))

for (i in 1:length(string_list)){

  substring <- string_list[[i]]
  substring <- substring[complete.cases(substring)]
  
  m <- substring[2] %>% str_split(' ') %>% unlist() %>% as.numeric()
  k <- substring[3] %>% str_split(' ') %>% unlist() %>% as.numeric()
  n <- substring[4] %>% str_split(' ') %>% unlist() %>% as.numeric()
  
  matrix <- outer(m, k, FUN = "+")
  matrix[matrix < 0] <- NA
  
  x <- lapply(n, get_smallest, matrix = matrix)
}

sink()

end_time <- Sys.time()
end_time - start_time




read_delim(here('bioinformatics_contest', 'output', glue('metabolite_annotation_{test_number}.txt')), delim = ' ')




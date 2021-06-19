suppressMessages(library(tidyverse))
library(here)

args = commandArgs(trailingOnly=TRUE)

calculate_probability <- function(population_info){

  k <- population_info[1]
  m <- population_info[2]
  n <- population_info[3]
  
  total_population <- k + m + n
  
  total_combos <- choose(total_population, 2)
  valid_combos <- choose(k, 2) + k*m + k*n + .5*m*n + .75*choose(m,2)
  probability <- valid_combos/total_combos
  
  return(probability)
}

result <- read_file(args[1]) %>%
  str_split(' ', simplify = T) %>% 
  as.numeric() %>%
  calculate_probability()

print(result)

write_file(as.character(result), here('output', '04_IPRB.txt'))


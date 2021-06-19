library(gtools)
library(here)
library(tidyverse)

args = commandArgs(trailingOnly=TRUE) 
n = scan(args[1])

perms <- data.frame(permutations(n, n))

write.table(perms, file = here('stronghold', 'output', '10_PERM_table.txt'), col.names = F, row.names = F)

result <- read_file(here('stronghold', 'output', '10_PERM_table.txt'))

result <- paste0(nrow(perms), '\n', result)

sink(here('stronghold', 'output', '10_PERM.txt'))
cat(result)
sink()

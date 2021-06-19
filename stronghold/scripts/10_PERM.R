library(gtools)
library(here)
library(tidyverse)

args = commandArgs(trailingOnly=TRUE) 
n = scan(args[1])
output_file <- here('stronghold', 'output', '10_PERM.txt')

perms <- data.frame(permutations(n, n))

# save result
cat(paste0(nrow(perms), '\n'), file = outuput_file)
write.table(perms, file = outuput_file, sep = ' ', col.names = F, row.names = F, append = T)

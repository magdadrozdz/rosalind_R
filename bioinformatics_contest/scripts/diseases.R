library(dplyr)

nodes = 10
root = 1
parents = c(1, 1, 3, 3, 4, 4, 5, 5, 5)   
children = c(2:nodes)

pars <- tibble(nodes_no = parents)
children <- tibble(nodes_no = children)

icv <- c(5, 7, 8, 13, 18, 14, 15, 21, 20, 29)
nodes_no <- c(1:nodes)
icv_vals <- tibble(nodes_no,  icv)

x <- inner_join(pars, icv_vals, by = c('nodes_no'))
y <- inner_join(children, icv_vals, by = c('nodes_no'))
xy <- bind_cols(x,y)

#xy <- tibble(xy, c(1, 5, 1, 5))

names(xy) <- c('parents', 'par_icv', 'children', 'child_icv')


d1 <- c(2,4)
d2 <- c(10)

p1 <- c(5, 9, 8)
p2 <- c(6)


xy %>% 
  group_by(parents, children) %>%
  summarise(sum = sum(child_icv, par_icv))

xy %>% 
  filter(children %in% p1) %>% 
  group_by(parents) %>% 
  summarise(sum = sum(child_icv))# %>% 
  # find max 
  
  xy %>% 
  filter(children %in% p2) %>% 
  group_by(parents) %>% 
  summarise(sum = sum(child_icv)) 
  

top_5_age <- function(age){
  age %>% 
    group_by(POA_CODE, State) %>% 
    tidyr::gather(age, count, 3:23, na.rm = TRUE, convert = TRUE) %>% 
    arrange(POA_CODE) %>% 
    top_n(5, count)  
}

top_5_religion <- function(religion){
  religion %>% 
    group_by(POA_CODE, State) %>% 
    tidyr::gather(religion , count, 3:9, na.rm = TRUE, convert = TRUE) %>% 
    arrange(POA_CODE) %>% 
    top_n(7, count)  
}

top_5_industry <- function(industry){
  industry %>% 
    group_by(POA_CODE, State) %>% 
    tidyr::gather(religion , count, 3:23, na.rm = TRUE, convert = TRUE) %>% 
    arrange(POA_CODE) %>% 
    top_n(5, count)  
}

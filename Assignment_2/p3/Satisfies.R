Satisfies<-function(h, x) {
  # Checks if an instance x satisfies a hypothesis h.
  
  satisfies = TRUE
  for(i in 1:length(h)) {
    if(h[i] != '?' && ! grepl(x[i+1], h[i])) {
      satisfies =  FALSE
      break
    }
  }
  
  satisfies
}
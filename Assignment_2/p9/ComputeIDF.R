ComputeIDF<-function(word_id = -1) {
  source('DocFreq.R')
  
  n_words <- dim(vocabulary)[1]
  n_documents <- dim(document_labels)[1]
  idf <- NULL
  
  if(word_id == -1) {
    for(word_id in 1:n_words) {
      word <- as.character(vocabulary[[1]][word_id])
      idf <- rbind(idf, c(word, log(n_documents/DocFreq(word))))
    }
  } else {
    word <- as.character(vocabulary[[1]][word_id])
    idf <- rbind(idf, c(word, log(n_documents/DocFreq(word))))
  }
  
  idf
}
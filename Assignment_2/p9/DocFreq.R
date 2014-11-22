DocFreq<-function(word) {
  word_id = which(vocabulary == word)
  documents_count = length(which(word_per_doc_count[, 2] == word_id))
  
  documents_count
}
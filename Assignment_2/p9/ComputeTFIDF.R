ComputeTFIDF<-function() {
  # For simple_triplet_matrix
  library(slam)
  
  n_words <- nrow(vocabulary)
  n_documents <- nrow(document_labels)
  tfidf <- NULL
  
  for(doc_id in 1:n_documents) {
    # Compute rows for the current document.
    rows <- word_per_doc_count[word_per_doc_count$V1 == doc_id, ]
    total_word_count <- sum(rows[, 2])
    
    denom <- 0.0
    for(word_id in rows[, 2]) {
      cur_word_freq <- rows[rows$V2 == word_id, 3]
      tf = log(1 + cur_word_freq/total_word_count)
      idf = as.numeric(ComputeIDF(word_id)[2])
      
      tfidf <- rbind(tfidf, c(doc_id, word_id, tf * idf))
      denom <- denom + (tf * idf)^2
    }
    denom <- sqrt(denom)
    
    tfidf <- cbind(tfidf[, 1:2], tfidf[, 3]/denom)
  }
  
  tfidf_sparse = simple_triplet_matrix(tfidf[, 1], tfidf[, 2], tfidf[, 3])
  tfidf_sparse
}
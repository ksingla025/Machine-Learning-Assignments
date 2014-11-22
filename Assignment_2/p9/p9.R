# Required for simple_triplet_matrix
library(slam)

source('DocFreq.R')
source('ComputeIDF.R')
source('ComputeTFIDF.R')
source('SphericalKMeans.R')
source('FarthestFirstPoint.R')

word_per_doc_count <- read.table('../datasets/newsgroup/train.data')
vocabulary <- read.table('../datasets/newsgroup/vocabulary.txt')
document_labels <- read.table('../datasets/newsgroup/train.label')

# Take d+1 documents of each category
d <- 5
temp <- unique(document_labels)
new_word_per_doc_count <- NULL
new_document_labels <- NULL
for(i in rownames(temp)) {
  doc_labels = as.numeric(i):(as.numeric(i) + d)
  new_document_labels <- c(new_document_labels, document_labels[doc_labels, ])
  new_word_per_doc_count = rbind(new_word_per_doc_count, 
                                 word_per_doc_count[word_per_doc_count$V1 %in% doc_labels, ])
}
document_labels <- new_document_labels
word_per_doc_count <- new_word_per_doc_count
remove(new_document_labels)
remove(new_word_per_doc_count)
document_labels <- as.data.frame(document_labels)

tfidf <- ComputeTFIDF()

k_values <- c(5, 10, 15, 20, 25)
for(k in k_values) {
  clusters <- SphericalKMeans(tfidf, k)
}

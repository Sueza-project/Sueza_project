library(tidyverse)
library(tm)
## http://edutechwiki.unige.ch/fr/Tutoriel_tm_text_mining_package
## https://cran.r-project.org/web/packages/tm/vignettes/tm.pdf 

archive_test <- file.path ("D:","University of Trieste","project", "Sueza_project", "Data","Yemba","corpus")
archive_test
dir (archive_test)
corpus.source <- Corpus(DirSource(archive_test,encoding = "UTF-8"),readerControl = list(language = "lat"))

show (corpus.source)
## Inspection et utilisation de corpus
# print a short overview

print(corpus.source)

# show all
inspect(corpus.source)


# display the second document
inspect(corpus.source[2])

# afficher tous les textes
names(corpus.source)

lapply(corpus.source[1:4], as.character)

# Transformations

#Once we have a corpus we typically want to modify the documents in it, e.g., stemming, stopword removal,
#et cetera.

  # Extra whitespace is eliminated by:
reuters <- tm_map(corpus.source, stripWhitespace)

#removePunctuation()
#Enlever les ponctuations
reuters <- tm_map (reuters, removePunctuation, preserve_intra_word_dashes = TRUE)

# Creating Term-Document Matrices
dtm <- DocumentTermMatrix(reuters)
inspect(dtm)

#  Imagine we want to find those terms that occur at least five times

l <-findFreqTerms(dtm, 1)

# Wordclouds
library(wordcloud)
wordcloud(reuters,
          scale=c(3,0.1), rot.per=0.35, 
          min.freq=1, use.r.layout=FALSE,
          colors= brewer.pal(8,"Spectral")
)

wordcloud (words (reuters[[2]]),
           scale=c(5,0.1), rot.per=0.35, 
           min.freq=1, use.r.layout=FALSE,
           colors= brewer.pal(8,"Spectral")
)

wordcloud(words (reuters[[3]]),
          scale=c(5,0.1), rot.per=0.35, 
          min.freq=1, use.r.layout=FALSE,
          colors= brewer.pal(8,"Spectral")
)

writeCorpus(reuters)
dataframe<-data.frame(text=unlist(sapply(l, `[`, "content")), stringsAsFactors=F)
Encoding(l)
write.table(l, file = "dict_yemba.txt", sep = "\t",
            row.names = FALSE)


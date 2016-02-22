# Clustering library
library(mclust)

# Parse input
args = commandArgs(trailingOnly = TRUE)
con = textConnection(args[[1]])
data = read.csv(con, header = FALSE)
data = as.matrix(data)
close(con)

# Clustering
allBIC = c()
allClassification = list()
p = 0
for(G in 2:20)
{
  # Cluster the data points
  clust = Mclust(data, G=G)
  allBIC[G] = clust$bic
  allClassification[[G]] = clust$classification

  # Update progress
  p = p + 5
  writeLines(as.character(p), 'progress.txt')
}

# Choose best clustering
classif = allClassification[[which.max(allBIC)]]

# Save result to file
out = c()
for(i in 1:which.max(allBIC))
{
  tmp = data
  sdiff = setdiff(1:dim(data)[1], which(classif == i))
  tmp[sdiff, 2] = "NaN"
  out = cbind(out, tmp[,2])
}
write.csv(out, file="results.txt", quote=FALSE)
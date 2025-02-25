library(adegenet)
library(phangorn)
library(pegas)



dna <- fasta2DNAbin(file="outfile.fas")

#Compute genetic distances using Tamura and New 1993 model which allows for different rates of transistions and transversions, heterogenous base frequencies and
#between site variation of the substitution rate.
D <- dist.dna(dna, model="TN93")
class(D)


#Try using the unweighted pair group method with arithmetic mean a hierarchical clustering algorithm

tre3 <- as.phylo(hclust(D,method = "average"))
y <- as.vector(as.dist(cophenetic(tre3)))
plot(x,y, xlab = "original pairwise distances", ylab= "pairwise disances on the tree", main = "Is UPGMA method appropriate?",pch=20,col=transp("black",.1),cex=3)
abline(lm(y~x),col="red",lwd=7)
cor(x,y)^2
plot(tre3,cex=.5)
title("UPMGA tree")

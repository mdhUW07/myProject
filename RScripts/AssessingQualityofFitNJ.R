library(adegenet)
library(phangorn)
library(pegas)



dna <- fasta2DNAbin(file="outfile.fas")

#Compute genetic distances using Tamura and New 1993 model which allows for different rates of transistions and transversions, heterogenous base frequencies and
#between site variation of the substitution rate.
D <- dist.dna(dna, model="TN93")
class(D)





#Assessing the quality of a phylogeny
x <- as.vector(D)
y <- as.vector(as.dist(cophenetic(tre)))
plot(x,y, xlab = "original pairwise distances", ylab= "pairwise disances on the tree", main = "Is Neighbor Joining method appropriate?",pch=20,col=transp("black",.1),cex=3)
abline(lm(y~x),col="red",lwd=7)
cor(x,y)^2


#Distance based methods
library(ape)
library(adegenet)
#install.packages("phangorn",dep=TRUE)
library(phangorn)
library(pegas)
#The data used in this practical are 120 DNA sequences of Bombus terrestris dalmatinus the buff tailed bumblebee of the mitochondrial cytochrom b gene sequence from the research paper.
#Alignments have been realized before hand using standard tools (Clustalw for basic alignment)


dna <- fasta2DNAbin(file="outfile.fas")

#Haplotype network
h <- haplotype(dna)
#Haplonet
hN <- haploNet(h)
#Dataframe of 20 different haplotypes
HapTyp_DF = as.data.frame(diffHaplo(h,1:20,strict = FALSE))
HapTyp_DF = t(HapTyp_DF)

#Compute genetic distances using Tamura and New 1993 model which allows for different rates of transistions and transversions, heterogenous base frequencies and
#between site variation of the substitution rate.
D <- dist.dna(dna, model="TN93")
class(D)
length(D)
temp <- as.data.frame(as.matrix(D))
table.paint(temp,cleg=0, clabel.row=.5,clabel.col = .5)

#Darker shades of grey represent greater distances.

#Building a neighbor joining tree
tre <- nj(D)
class(tre)
tre <- ladderize(tre)

plot(tre, cex=.6)
MyTreetreesMyTreetreesMyTreetreesMyTree <- read.tree("outfile.dnd",keep.multi = TRUE)
png("my_file_png")
plot(MyTree)

#Assessing the quality of a phylogeny
x <- as.vector(D)
y <- as.vector(as.dist(cophenetic(tre)))
plot(x,y, xlab = "original pairwise distances", ylab= "pairwise disances on the tree", main = "Is Neighbor Joining method appropriate?",pch=20,col=transp("black",.1),cex=3)
abline(lm(y~x),col="red",lwd=7)
cor(x,y)^2
#The original pairwise disances and pairwise distances on the tree are strongly coorelated.

#Try using the unweighted pair group method with arithmetic mean a hierarchical clustering algorithm

tre3 <- as.phylo(hclust(D,method = "average"))
y <- as.vector(as.dist(cophenetic(tre3)))
plot(x,y, xlab = "original pairwise distances", ylab= "pairwise disances on the tree", main = "Is UPGMA method appropriate?",pch=20,col=transp("black",.1),cex=3)
abline(lm(y~x),col="red",lwd=7)
cor(x,y)^2
plot(tre3,cex=.5)
title("UPMGA tree")


#############################################################################

#MAximum parsimony phylogenies



dev.new()dev.new()trees

MyTree <- read.tree("GLR.dnd",keep.multi = TRUE)
png("my_file_png")
plot(MyTree)


dev.new()

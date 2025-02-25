library(adegenet)
library(phangorn)
library(pegas)



dna <- fasta2DNAbin(file="outfile.fas")

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
title("A Simple Neigbor Joining Tree for Terrestris Bombus")


MyTreetreesMyTreetreesMyTreetreesMyTree <- read.tree("outfile.dnd",keep.multi = TRUE)
png("my_file_png")
plot(MyTree)
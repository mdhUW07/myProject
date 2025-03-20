library(adegenet)
library(phangorn)
library(pegas)
library(devtools)



dna <- fasta2DNAbin(file="outfile.fas")

#Compute genetic distances using Kimura 2 parameter model which allows for different rates of transitions and transversions

D <- dist.dna(dna, model="K80")

temp <- as.data.frame(as.matrix(D))

table.paint(temp,cleg=0, clabel.row=.5,clabel.col = .5)

#Darker shades of grey represent greater distances.

tre <- nj(D)

tre <- ladderize(tre)

plot(tre, cex=.6)



library(adegenet)
library(phangorn)
library(pegas)

#Read fasta file
dna <- fasta2DNAbin(file="outfile.fas")

#Convert to a phangorn object
dna2 <- as.phyDat(dna)

#Create initial tree object
tre.ini <- nj(dist.dna(dna,model = "raw"))

#A parsimony score for the initial tree
parsimony(tre.ini,dna2)

#Search for the tree with the maximum parsimony score
tre.pars <- optim.parsimony(tre.ini,dna2)

#Plot the tree
plot(tre.pars,cex=0.6)
title("A Simple Rooted Parsimonious Tree for Terrestris Bombus")

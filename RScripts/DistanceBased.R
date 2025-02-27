library(adegenet)
library(phangorn)
library(pegas)

args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1){
  # default output file
 # args[2]="homologs.csv"
}


#dna <- fasta2DNAbin(file="outfile.fas")
dna <- fasta2DNAbin(args[1])

#Compute genetic distances using Tamura and New 1993 model which allows for different rates of transistions and transversions, heterogenous base frequencies and
#between site variation of the substitution rate.
print("running TN93 algorithm for Pairwise Distance Based Matrix")
D <- dist.dna(dna, model="TN93")
class(D)
length(D)

print("Building Distance Matrix")
temp <- as.data.frame(as.matrix(D))
print("Table.paint matrix")
table.paint(temp,cleg=0, clabel.row=.5,clabel.col = .5)


#Darker shades of grey represent greater distances.

print("Building a neighbor joining tree")
tre <- nj(D)
class(tre)
print("ladderize tree")
tre <- ladderize(tre)

print("Plotting Tree")
plot(tre, cex=.6)
title("A Simple Neigbor Joining Tree for Terrestris Bombus")


#MyTreetreesMyTreetreesMyTreetreesMyTree <- read.tree("outfile.dnd",keep.multi = TRUE)
#png("my_file_png")
#plot(MyTree)
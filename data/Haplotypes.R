library(adegenet)
#install.packages("phangorn",dep=TRUE)
library(phangorn)
library(pegas)
#The data used in this practical are 120 DNA sequences of Bombus terrestris dalmatinus the buff tailed bumblebee of the mitochondrial cytochrom b gene sequence from the research paper.
#Alignments have been realized before hand using standard tools (Clustalw for basic alignment)

dna <- fasta2DNAbin(file="outfile.fas")
dna <- fasta2DNAbin(file="outfile.fas")

#Haplotype network
h <- haplotype(dna)
#Haplonet
hN <- haploNet(h)
hN
#Dataframe of 20 different haplotypes
HapTyp_DF = as.data.frame(diffHaplo(h,1:20,strict = FALSE))
HapTyp_DF = t(HapTyp_DF)
View(HapTyp_DF)



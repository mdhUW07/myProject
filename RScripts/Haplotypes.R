library(adegenet)
#install.packages("phangorn",dep=TRUE)
library(phangorn)
library(pegas)
#The data used in this practical are 120 DNA sequences of Bombus terrestris dalmatinus the buff tailed bumblebee of the mitochondrial cytochrom b gene sequence from the research paper.
#Alignments have been realized before hand using standard tools (Clustalw for basic alignment)

args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1){
  # default output file
  args[2]="homologs.csv"
}

print("Reading multiple sequence file")
dna <- fasta2DNAbin(args[1])

print("Making a Haplotype network")

h <- haplotype(dna)
h
print("Making a Haplonet object")
hN <- haploNet(h)
hN
print("Making a Dataframe of 20 different haplotypes")

HapTyp_DF = as.data.frame(diffHaplo(h,1:20))

print("Transposing the DataFrame")

HapTyp_DF = t(HapTyp_DF)

#View(HapTyp_DF)
print("Writing Dataframe to CSV file")
write.table(HapTyp_DF,file = args[2])


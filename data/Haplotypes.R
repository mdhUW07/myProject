library(adegenet)
library(ggtree)
library(phangorn)
library(pegas)
library(ggplot2)

#The data used in this practical are 120 DNA sequences of Bombus terrestris dalmatinus the buff tailed bumblebee of the mitochondrial cytochrom b gene sequence from the research paper.
#Alignments have been realized before hand using standard tools (Clustalw for basic alignment)

dna <- fasta2DNAbin(file="outfile.fas")


h <- haplotype(dna)

#Fit Kimura 2 parameter model
D_K81 = dist.dna(h,model="K80")
tree <- nj(D_K81)
ggt <- ggtree::ggtree(tree,cex = 0.8, aes(color=branch.length))+scale_color_continuous(high='lightskyblue1',low='coral4')+geom_tiplab(align=TRUE, size=2)+geom_treescale(y = - 5, color = "coral4", fontsize = 4)
njmsaplot<-msaplot(ggt,h,offset = 0.009, width=1, height = 0.5, color = c(rep("rosybrown", 1), rep("sienna1", 1), rep("lightgoldenrod1", 1), rep("lightskyblue1", 1)))
njmsaplot

#Fit Kimura 2 parameter model with mutltiple DNA sequences
D_K81 = dist.dna(dna,model="K80")
tree <- nj(D_K81)
ggt <- ggtree::ggtree(tree,cex = 0.8, aes(color=branch.length))+scale_color_continuous(high='lightskyblue1',low='coral4')+geom_tiplab(align=TRUE, size=2)+geom_treescale(y = - 5, color = "coral4", fontsize = 4)
njmsaplot<-msaplot(ggt,dna,offset = 0.009, width=1, height = 0.5, color = c(rep("rosybrown", 1), rep("sienna1", 1), rep("lightgoldenrod1", 1), rep("lightskyblue1", 1)))
njmsaplot


#Haplonet
hN <- haploNet(h)
hN


#Dataframe of 20 different haplotypes
HapTyp_DF = as.data.frame(diffHaplo(h,1:20,strict = FALSE))
HapTyp_DF = t(HapTyp_DF)
View(HapTyp_DF)



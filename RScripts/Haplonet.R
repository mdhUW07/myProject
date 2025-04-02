library(adegenet)
library(ggtree)
library(phangorn)
library(pegas)
library(ggplot2)

dna <- fasta2DNAbin("outfile.fas")


h <- haplotype(dna)

hname<-paste("H", 1:nrow(h), sep = "")
rownames(h)= paste(hname)
net<-haploNet(h, d = NULL, getProb = TRUE) #constructs the haplotype network
net
ind.hap<-with(
  utils::stack(setNames(attr(h, "index"), rownames(h))),
  table(hap=ind, individuals=rownames(dna)[values])
)


ubg<-c(rep("dodgerblue4",1), rep("royalblue2",1), rep("skyblue1",1), rep("red",1), rep("olivedrab4",1), 
       rep("olivedrab3",1), rep("olivedrab1",1), rep("darkseagreen1",1))


hapcol<-c("Aksu", "Demre", "Kumluca", "Firm", "Bayatbadem", "Geyikbayir", "Phaselis", "Termessos")
bg<-c(rep("dodgerblue4", 15), rep("olivedrab4",15), rep("royalblue2", 15), rep("red",15), rep("olivedrab3",15), 
      rep("skyblue1", 15), rep("olivedrab1", 15),  rep("darkseagreen1", 15))
par(mar=c(0.001,0.001,0.001,0.001))
plot(net, size=attr(net, "freq"), bg = bg, scale.ratio = 2, cex = 0.7, labels=TRUE, pie = ind.hap, show.mutation=1, font=2, fast=TRUE)
legend(x=-36,y=53, hapcol, fill=ubg, cex=0.8, ncol=1, bty="n", x.intersp = 0.2)

#View the haplotype sequences
alview(h,file = "HSEQCSV.txt")

###################################################################################################################################################

h<-pegas::haplotype(dna, strict = FALSE, trailingGapsAsN = TRUE)#extracts haplotypes from DNAbin object
hname<-paste("H", 1:nrow(h), sep = "")
rownames(h)= paste(hname)
net<-haploNet(h, d = NULL, getProb = TRUE)#constructs the haplotype network
net
ind.hap<-with(
  utils::stack(setNames(attr(h, "index"), rownames(h))),
  table(hap=ind, individuals=rownames(dna))
)

par(mar=c(0.001,0.001,0.001,20))
plot(net, size=attr(net, "freq"), scale.ratio = 3, cex = 0.6, labels=TRUE, pie = ind.hap, show.mutation=1, font=2, fast=TRUE)
legend(x= -63,y=-50, colnames(ind.hap), fill=rainbow(ncol(ind.hap)), cex=0.40, ncol=6, x.intersp=0.9, text.width=21)


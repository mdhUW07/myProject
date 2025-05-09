# Create Github class respository assignment

120 mitochondrial cyt b sequences of B. terrestris dalmatinus.
The files are in multiple sequences
FASTA format file and the dataset is about
the mitochondrial cytochrome b gene 
sequences and are 373 base pairs in length
and were collected from 8 different beehives
in Antalya. Because the files are in FASTA format, not FASTQ, there are no
quality control measures per base read, therefore, 
I do not believe a quality control step is necessary.
Just a small edit

## Create an indpendent computer environment in conda to make managing the workflow easier

Installation

We are following the steps on the Installation.

## Make a parent directory and name it miniconda3
```
    mkdir -p ~/miniconda3
```
## Use wget command to download from source package online
```
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
```
## Run the shell script by invoking bash command on the executable bash file
```    
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
```
## Remove the bash file
```
    rm ~/miniconda3/miniconda.sh
```
## Check which version you have installed
```
    which conda
```
## Which python version
```
    which python -V
```
## Create conda environment
```
    conda create --name phyluce phyluce
```
## Activate the environment
```
    conda activate phyluce
```
## Install t_coffee alignment software from bioconda channel
```
    conda install bioconda::t_coffee
```

##Install standard phylogenetic R packages into your conda environment 
```
    conda install conda-forge::r-base
    conda install r-essentials
    conda install bioconda::r-adegenet
    conda install bioconda::r-phangorn
    conda install bioconda::r-pegas
    conda install bioconda::figtree
    conda install bioconda::modeltest-ng
    conda install bioconda::iqtree
    conda install bioconda::muscle
    conda install bioconda::clustalw
    conda install bioconda::raxml-ng
    sudo apt install texlive-latex-base
    sudo apt install texlive-latex-recommended
    conda install bioconda::seqmagick
    conda install bioconda::tracer


```
## Show list of available software packages and their versions in your phyluce environment
```
    conda list
```
## If you want to clone my repository which has the main sequencing file you can but there is a lot of unecessary information

```
git clone https://github.com/mdhUW07/myProject

```

# Aligning my data with t_coffee
Multiple sequence alignment of the cyt b sequences is a prerequesite for phylogentic analysis. T_coffee is a free open source software used for multiple sequence alignment, which
progressivley optimizes the alignment based on pairwise alignments that is comparable to another software ClustalW. I will include a script of the command lines necessary to achieve the 
progressive alginment after prerequisite software has been downloaded to the operating system of your choice. In the data directory a master source file from which all downstream analysis
start is the first argument for running the t_coffee multiple sequence alignment software. One of the weaknesses of t-coffee is the complexity of user parameter specifications which may
require a deeper understanding of the underlying algorithms. In order to achieve an optimum alignment knowledge of how these different parameter specifications work depending on the specific data set and goals. You
can see there are 120 DNA sequences running on 8 core processors with the FASTA file as an input, with the manual gap penalities are set to zero by default and are only applied after the global alignment method
has been selected either by choice or by default. However the gap penalties can be customized accordingly can be changing via the flag arguments -gapopen and -gapext. The guide tree is made by using a neighbor jointing method by default, but is possible
to compute a UPGMA a rooted tree unweighted pair group method with arithmetic mean.



```
t_coffee data/outfile.fas 

```

```
INPUT FILES
	Input File (S) Desktop/myProject/data/outfile.fas  Format fasta_seq
	Input File (M) proba_pair 

Identify Master Sequences [no]:

Master Sequences Identified
INPUT SEQUENCES: 120 SEQUENCES  [DNA]
	Multi Core Mode: 8 processors:

	--- Process Method/Library/Aln SDesktop/myProject/data/outfile.fas
	--- Process Method/Library/Aln Mproba_pair
	xxx Retrieved SDesktop/myProject/data/outfile.fas
	xxx Retrieved Mproba_pair

	All Methods Retrieved

MANUAL PENALTIES: gapopen=0 gapext=0

	Library Total Size: [5348776]

Library Relaxation: Multi_proc [8]
 
!		[Relax Library][TOT=   15][100 %]

Relaxation Summary: [5348776]--->[5330672]



UN-WEIGHTED MODE: EVERY SEQUENCE WEIGHTS 1

MAKE GUIDE TREE 
	[MODE=nj][DONE]

PROGRESSIVE_ALIGNMENT [Tree Based]

	Group  239: [Group  238 (  23 seq)] with [Group  216 (  97 seq)]-->[Len=  373][PID:13042][Forked]


!		[Final Evaluation][TOT=   46][100 %]



OUTPUT RESULTS
#### File Type= GUIDE_TREE      Format= newick          Name= outfile.dnd
#### File Type= MSA             Format= aln             Name= outfile.aln
#### File Type= MSA             Format= html            Name= outfile.html

# Command Line: t_coffee Desktop/myProject/data/outfile.fas  [PROGRAM:T-COFFEE]
# T-COFFEE Memory Usage: Current= 33.629 Mb, Max= 143.352 Mb
# Results Produced with T-COFFEE Version_12.00.7fb08c2 (2018-12-11 09:27:12 - Revision 7fb08c2 - Build 211)
# T-COFFEE is available from http://www.tcoffee.org
# Register on: https://groups.google.com/group/tcoffee/

```
# Muscle alignment method 

This alignmnet method produces the output file used in the maximum likelihood raxml-ng software that optimizes the phylogenetic tree and is used with modeltest-ng software to find the 
best model based on information criteria.

```
muscle -align data/outfile.fas -output Bombus_terrestris_dalmatinus-alligned-muscle.fasta

```

# ClustalW alignment method
ClustalW is a third generation computer progam used for multiple sequence alignment in bioinformatics. It is claimed to have improved on the progressive alignment method algorithm, which 
computes similarity scores between sequences which produces pairwise alignments. There are set penalties for gaps, but in this case all arguments are set to default because it is such a 
great alignment. After a pairwise matrix if formed a neighbor-joining method is employed to make a guide tree. It is accurate, and consistent when compared against other softwares such as 
MAFFT, and T-Coffee. 
```
clustalw -infile=myProject/data/outfile.fas -outfile=Bombus_terrestris_aligned_sequences.fasta -output=fasta
```
## The aligned sequences are independently given per species sequence

# Haplotype R Script
A Haplotype is a group of DNA variations bthat are inherited together from a single parent. It comes from the word "haploid" and by examining these haplotypes reserachers 
can identify patterns of genetic variation associated with disease states. The R-Script produces a haplotype matrix with the rows as haplotype groups, in this case there are 20 unique haplotypes 
and the columns are the position in the sequence however how this protein is encoded. The haplotye diversity is a probability measure that determines how likely two randomly chosen haplotypes will be the same.
In this case the probability measure that two randomly chosen haplotypes in this population will be different is 77.37%. This is a good indicator of how diverse the poulation under study is. 


```
Haplotypes.R 

library(adegenet)
library(phangorn)
library(pegas)
library(ggtree)
library(ggplot2)
#The data used in this practical are 120 DNA sequences of Bombus terrestris dalmatinus the buff tailed bumblebee of the mitochondrial cytochrom b gene sequence from the research paper.
#Alignments have been realized before hand using standard tools (Clustalw for basic alignment)

dna <- fasta2DNAbin("outfile.fas")


h <- haplotype(dna)

ape::alview(h,file = "homologallview.txt")

```

![alt2](/Pics/HomologSeq.png)


# Estimating a Distance based phylogenetic tree and Parsimony based phylogenetic tree with R

```
DistanceBased.R

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
```
The RScript computes a pairwise distance matrix from the 120 DNA sequences of the cyt B gene of the Terrestris Bombus using a model of evolution from Tamura (1992). The model assumes
distinct rates for both kinds of transistions A<-->G and C <-->T, and transversions. The base frequencies are estimated and not assumed to be equal. 

![alt](/Pics/DistanceBasedPhylogenies.png)

The Rscript performs the neighbor-joining tree estimation of Saitou and Nei (1987). It takes as an input the distance matrix computed in the previous step.

![alt](/Pics/TerrestrisBombusNJTree.png)


```
ParsimonyBasedTree.R 

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
```
In the parsimony based method of computing a phylogenetic tree the parsimony ratchet is a preferred way to search for the best parsimony tree. After returning a parsinomy score
on the initial tree, the optimal parsimony function returns a tree after using NNI rearrangements. 

![alt](/Pics/ParsimonyTree.png)


```
AssessingQualityofFitNJ.R

library(adegenet)
library(phangorn)
library(pegas)



dna <- fasta2DNAbin(file="outfile.fas")

#Compute genetic distances using Kimura 2 parameter evoulutionary model which allows for different rates of transistions and transversions, heterogenous base frequencies and
#between site variation of the substitution rate.
D <- dist.dna(dna, model="K80")
class(D)





#Assessing the quality of a phylogeny
x <- as.vector(D)
y <- as.vector(as.dist(cophenetic(tre)))
plot(x,y, xlab = "original pairwise distances", ylab= "pairwise disances on the tree", main = "Is Neighbor Joining method appropriate?",pch=20,col=transp("black",.1),cex=3)
abline(lm(y~x),col="red",lwd=7)
cor(x,y)^2
```
After using the Neighbor-Joining Method to construct the pairwise distance matrix, we can assess it fit by compaing the original distances in the matrix to the distances found on 
the pylogenetic tree. The two distance measurements are strongly correlated at 0.9396.

![alt](/Pics/NJmethod.png)


# Unweighted pair group method with Arithmetic Mean

Another method that uses hierarchical clustering taking points from the distances between clusters and distances between two objects in each cluster. Compared to NJ method it has a 
smaller correlation, and not as good of a fit.

![alt](/Pics/UPGMAmethod.png)




# Raxml Maximum Likelihood Tree Construction
Perform an all-in-one analysis (ML tree search + non-parametric bootstrap) (10 randomized parsimony starting trees, fixed empirical substitution matrix (LG), 
empirical aminoacid frequencies from alignment, 8 discrete GAMMA categories, 200 bootstrap replicates):



# GGTREE and GGPLOT2 to create a dynamic phylogenetic tree at the sample level


```
GGTREE.R


library(adegenet)
library(phangorn)
library(pegas)
library(ggtree)
library(ggplot2)


dna <- fasta2DNAbin(file="outfile.fas")


an<-as.alignment(dna)  #converting DNAbin to alignment format
nm<-as.matrix(an)       #converting alignment to matrix
dnamat<-as.matrix(labels(dna)) #extraction of the sample names
dna
class(dna)
ddna<-dist.dna(dna, model = "K80") #computing distance by ape package with K80 model derived by Kimura (1980)
tree<-nj(ddna)
ggt<-ggtree(tree, cex = 0.8, aes(color=branch.length))+scale_color_continuous(high='lightskyblue1',low='coral4')+geom_tiplab(align=TRUE, size=2)+geom_treescale(y = - 5, color = "coral4", fontsize = 4)

#The shared S2_Appendix.fas dataset is not contained missing value, different letter (N, R, K etc.) or gaps.
#If your sequences have gaps (-) or N, Y, K, R letter (IUPAC nucleotide code), 
#you have to add additional color in "color argument" below.
#For example, "rep("green",1,)" for gaps, "rep("pink",1,)" for N letter etc.
#However, you have to delete or fix the gaps to be able to do other analysis.
#If you have big data set, you can modified "width" and "height" arguments below for better images.

njmsaplot<-msaplot(ggt, dna, offset = 0.009, width=1, height = 0.5, color = c(rep("rosybrown", 1), rep("sienna1", 1), rep("lightgoldenrod1", 1), rep("lightskyblue1", 1)))
njmsaplot


```

![alt](/Pics/GGTREEPHYLNET.png)

```
raxml-ng --all -msa Bombus_terrestris_dalmatinus-alligned-muscle.fasta --model LG+G8+F --tree pars{10} --bs-trees 200

```
From the output using figtree downloaded from biocondaview the best fitting phylogenetic tree. If Gimp a photo editing software is downloaded you can open up the tree in a java script
and change the settings to visulalize the tree better/

```

figtree Bombus_terrestris_dalmatinus-alligned-muscle.fasta.raxml.bestTree

```
You can view the best tree

![alt](/Pics/Raxml_Muslce_align_Best_Tree.jpg)


# Fit a Kamura 2 parameter model using Raxml Maximum Likelihood

```
raxml-ng --msa ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta --model K80 --prefix Kamura2

RAxML-NG v. 1.2.2 released on 11.04.2024 by The Exelixis Lab.
Developed by: Alexey M. Kozlov and Alexandros Stamatakis.
Contributors: Diego Darriba, Tomas Flouri, Benoit Morel, Sarah Lutteropp, Ben Bettisworth, Julia Haag, Anastasis Togkousidis.
Latest version: https://github.com/amkozlov/raxml-ng
Questions/problems/suggestions? Please visit: https://groups.google.com/forum/#!forum/raxml

System: Intel(R) Core(TM) i5-8365U CPU @ 1.60GHz, 4 cores, 15 GB RAM

RAxML-NG was called at 04-Mar-2025 16:24:38 as follows:

raxml-ng --msa ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta --model K80 --prefix Kamura2

Analysis options:
  run mode: ML tree search
  start tree(s): random (10) + parsimony (10)
  random seed: 1741127078
  tip-inner: OFF
  pattern compression: ON
  per-rate scalers: OFF
  site repeats: ON
  logLH epsilon: general: 10.000000, brlen-triplet: 1000.000000
  fast spr radius: AUTO
  spr subtree cutoff: 1.000000
  fast CLV updates: ON
  branch lengths: proportional (ML estimate, algorithm: NR-FAST)
  SIMD kernels: AVX2
  parallelization: coarse-grained (auto), PTHREADS (auto)

[00:00:00] Reading alignment from file: ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta
[00:00:00] Loaded alignment with 120 taxa and 373 sites

NOTE: Reduced alignment (with duplicates and gap-only sites/taxa removed) 
NOTE: was saved to: /home/michael-hall/Desktop/myProject/alignmentmethods/muscle/Kamura2/Kamura2.raxml.reduced.phy

Alignment comprises 1 partitions and 35 patterns

Partition 0: noname
Model: K80
Alignment sites / patterns: 373 / 35
Gaps: 0.00 %
Invariant sites: 89.01 %


NOTE: Binary MSA file created: Kamura2.raxml.rba

Parallelization scheme autoconfig: 4 worker(s) x 1 thread(s)

[00:00:00] Generating 10 random starting tree(s) with 120 taxa
[00:00:00] Generating 10 parsimony starting tree(s) with 120 taxa
Parallel parsimony with 4 threads
Parallel reduction/worker buffer size: 1 KB  / 0 KB

[00:00:00] Data distribution: max. partitions/sites/weight per thread: 1 / 35 / 140
[00:00:00] Data distribution: max. searches per worker: 5

Starting ML tree search with 20 distinct starting trees

[00:00:00 -11801.692307] Initial branch length optimization
[00:00:00 -4770.473394] Model parameter optimization (eps = 10.000000)
[00:00:00 -4756.070290] AUTODETECT spr round 1 (radius: 5)
[00:00:00 -2375.317061] AUTODETECT spr round 2 (radius: 10)
[00:00:00 -1971.089882] AUTODETECT spr round 3 (radius: 15)
[00:00:00 -1717.247551] AUTODETECT spr round 4 (radius: 20)
[00:00:00 -1655.773759] AUTODETECT spr round 5 (radius: 25)
[00:00:00 -1655.751348] SPR radius for FAST iterations: 20 (autodetect)
[00:00:00 -1655.751348] Model parameter optimization (eps = 3.000000)
[00:00:00 -1654.853875] FAST spr round 1 (radius: 20)
[00:00:00 -1287.188060] FAST spr round 2 (radius: 20)
[00:00:00 -1283.530293] Model parameter optimization (eps = 1.000000)
[00:00:00 -1283.477807] SLOW spr round 1 (radius: 5)
[00:00:00 -1283.477759] SLOW spr round 2 (radius: 10)
[00:00:00 -1283.477759] SLOW spr round 3 (radius: 15)
[00:00:00 -1281.284536] SLOW spr round 4 (radius: 20)
[00:00:00 -1280.800941] SLOW spr round 5 (radius: 25)
[00:00:00 -1280.800941] Model parameter optimization (eps = 0.100000)

[00:00:00] [worker #0] ML tree search #1, logLikelihood: -1280.800929

[00:00:00 -11794.473100] Initial branch length optimization
[00:00:00 -4799.071655] Model parameter optimization (eps = 10.000000)
[00:00:00 -4772.252211] AUTODETECT spr round 1 (radius: 5)
[00:00:00 -2431.441053] AUTODETECT spr round 2 (radius: 10)
[00:00:00] [worker #2] ML tree search #3, logLikelihood: -1090.516295
[00:00:00 -1755.045474] AUTODETECT spr round 3 (radius: 15)
[00:00:00] [worker #1] ML tree search #2, logLikelihood: -1252.251236
[00:00:00 -1338.644834] AUTODETECT spr round 4 (radius: 20)
[00:00:01] [worker #3] ML tree search #4, logLikelihood: -1079.231714
[00:00:01 -1325.222843] AUTODETECT spr round 5 (radius: 25)
[00:00:01 -1325.219720] SPR radius for FAST iterations: 20 (autodetect)
[00:00:01 -1325.219720] Model parameter optimization (eps = 3.000000)
[00:00:01 -1324.957888] FAST spr round 1 (radius: 20)
[00:00:01 -1102.621462] FAST spr round 2 (radius: 20)
[00:00:01 -1083.845189] FAST spr round 3 (radius: 20)
[00:00:01 -1083.842474] Model parameter optimization (eps = 1.000000)
[00:00:01 -1083.263665] SLOW spr round 1 (radius: 5)
[00:00:01 -1083.263062] SLOW spr round 2 (radius: 10)
[00:00:01 -1083.262766] SLOW spr round 3 (radius: 15)
[00:00:01 -1083.262604] SLOW spr round 4 (radius: 20)
[00:00:01 -1083.262509] SLOW spr round 5 (radius: 25)
[00:00:01 -1083.262450] Model parameter optimization (eps = 0.100000)

[00:00:01] [worker #0] ML tree search #5, logLikelihood: -1083.262428

[00:00:01 -11717.288660] Initial branch length optimization
[00:00:01 -4679.239534] Model parameter optimization (eps = 10.000000)
[00:00:01 -4647.977416] AUTODETECT spr round 1 (radius: 5)
[00:00:01 -2299.138064] AUTODETECT spr round 2 (radius: 10)
[00:00:01 -1926.972199] AUTODETECT spr round 3 (radius: 15)
[00:00:01] [worker #2] ML tree search #7, logLikelihood: -1079.231722
[00:00:01] [worker #1] ML tree search #6, logLikelihood: -1068.193429
[00:00:01 -1831.852269] AUTODETECT spr round 4 (radius: 20)
[00:00:01 -1563.946637] AUTODETECT spr round 5 (radius: 25)
[00:00:01] [worker #3] ML tree search #8, logLikelihood: -1066.351080
[00:00:01 -1563.946637] SPR radius for FAST iterations: 20 (autodetect)
[00:00:01 -1563.946637] Model parameter optimization (eps = 3.000000)
[00:00:02 -1563.511460] FAST spr round 1 (radius: 20)
[00:00:02 -1228.367233] FAST spr round 2 (radius: 20)
[00:00:02 -1148.083421] FAST spr round 3 (radius: 20)
[00:00:02 -1138.131713] Model parameter optimization (eps = 1.000000)
[00:00:02 -1136.750387] SLOW spr round 1 (radius: 5)
[00:00:02] [worker #2] ML tree search #11, logLikelihood: -1075.481342
[00:00:02 -1136.750189] SLOW spr round 2 (radius: 10)
[00:00:02] [worker #3] ML tree search #12, logLikelihood: -1087.191911
[00:00:02 -1083.313428] SLOW spr round 3 (radius: 5)
[00:00:02 -1083.313364] SLOW spr round 4 (radius: 10)
[00:00:02 -1083.313320] SLOW spr round 5 (radius: 15)
[00:00:02 -1083.313290] SLOW spr round 6 (radius: 20)
[00:00:02] [worker #2] ML tree search #15, logLikelihood: -1083.648509
[00:00:02] [worker #3] ML tree search #16, logLikelihood: -1086.694195
[00:00:02 -1083.313270] SLOW spr round 7 (radius: 25)
[00:00:02 -1083.313255] Model parameter optimization (eps = 0.100000)

[00:00:02] [worker #0] ML tree search #9, logLikelihood: -1083.262349

[00:00:02 -9490.800282] Initial branch length optimization
[00:00:02 -1098.827202] Model parameter optimization (eps = 10.000000)
[00:00:02 -1094.533260] AUTODETECT spr round 1 (radius: 5)
[00:00:03 -1094.532748] SPR radius for FAST iterations: 5 (autodetect)
[00:00:03 -1094.532748] Model parameter optimization (eps = 3.000000)
[00:00:03 -1094.532725] FAST spr round 1 (radius: 5)
[00:00:03 -1094.532723] Model parameter optimization (eps = 1.000000)
[00:00:03 -1094.532723] SLOW spr round 1 (radius: 5)
[00:00:03 -1094.532723] SLOW spr round 2 (radius: 10)
[00:00:03 -1084.569768] SLOW spr round 3 (radius: 15)
[00:00:03] [worker #2] ML tree search #19, logLikelihood: -1082.329572
[00:00:03 -1084.567099] SLOW spr round 4 (radius: 20)
[00:00:03] [worker #3] ML tree search #20, logLikelihood: -1082.329579
[00:00:03 -1084.566170] SLOW spr round 5 (radius: 25)
[00:00:03 -1084.565752] Model parameter optimization (eps = 0.100000)

[00:00:03] [worker #0] ML tree search #13, logLikelihood: -1084.428878

[00:00:03 -9477.134336] Initial branch length optimization
[00:00:03 -1068.120424] Model parameter optimization (eps = 10.000000)
[00:00:03 -1063.133459] AUTODETECT spr round 1 (radius: 5)
[00:00:03 -1062.649629] AUTODETECT spr round 2 (radius: 10)
[00:00:03 -1062.649617] SPR radius for FAST iterations: 5 (autodetect)
[00:00:03 -1062.649617] Model parameter optimization (eps = 3.000000)
[00:00:03 -1062.649617] FAST spr round 1 (radius: 5)
[00:00:03 -1062.649614] Model parameter optimization (eps = 1.000000)
[00:00:03 -1062.649614] SLOW spr round 1 (radius: 5)
[00:00:03 -1062.649614] SLOW spr round 2 (radius: 10)
[00:00:03 -1062.649614] SLOW spr round 3 (radius: 15)
[00:00:03 -1062.649614] SLOW spr round 4 (radius: 20)
[00:00:03] [worker #1] ML tree search #10, logLikelihood: -1062.649156
[00:00:03 -1062.649614] SLOW spr round 5 (radius: 25)
[00:00:03 -1062.649614] Model parameter optimization (eps = 0.100000)

[00:00:03] [worker #0] ML tree search #17, logLikelihood: -1062.649614

[00:00:04] [worker #1] ML tree search #14, logLikelihood: -1082.329695
[00:00:04] [worker #1] ML tree search #18, logLikelihood: -1082.329140

Optimized model parameters:

   Partition 0: noname
   Rate heterogeneity: NONE
   Base frequencies (model): 0.250000 0.250000 0.250000 0.250000 
   Substitution rates (ML): 1.000000 2.016877 1.000000 1.000000 2.016877 1.000000 


Final LogLikelihood: -1062.649156

AIC score: 2601.298311 / AICc score: 3450.283386 / BIC score: 3534.633975
Free parameters (model + branch lengths): 238

WARNING: Best ML tree contains 93 near-zero branches!

Best ML tree with collapsed near-zero branches saved to: /home/michael-hall/Desktop/myProject/alignmentmethods/muscle/Kamura2/Kamura2.raxml.bestTreeCollapsed
Best ML tree saved to: /home/michael-hall/Desktop/myProject/alignmentmethods/muscle/Kamura2/Kamura2.raxml.bestTree
All ML trees saved to: /home/michael-hall/Desktop/myProject/alignmentmethods/muscle/Kamura2/Kamura2.raxml.mlTrees
Optimized model saved to: /home/michael-hall/Desktop/myProject/alignmentmethods/muscle/Kamura2/Kamura2.raxml.bestModel

Execution log saved to: /home/michael-hall/Desktop/myProject/alignmentmethods/muscle/Kamura2/Kamura2.raxml.log

Analysis started: 04-Mar-2025 16:24:38 / finished: 04-Mar-2025 16:24:43

Elapsed time: 4.417 seconds

```

The log likelihood is a condtional distribution based on the observed sample with the primary objective of estimating the unknown parameter by maximizing the likelihood. The 
final log likelihood for the kamura 2 parameter model is -1062.649156 with the estimated transition rate of 2.016877 and transversion rate of 1.00000. 

# Find the top 3 best model fits based on AIC, BIC, and AICc procedures.


```
 modeltest-ng -i ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta
--------------------------------------------------------------------------------
ModelTest-NG v0.1.7

Input data:
  MSA:        ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta
  Tree:       Maximum parsimony
    file:           -
  #taxa:            120
  #sites:           373
  #patterns:        35
  Max. thread mem:  2 MB

Output:
  Log:           ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta.log
  Starting tree: ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta.tree
  Results:       ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta.out

Selection options:
  # dna schemes:      11
  # dna models:       88
  include model parameters:
    Uniform:         true
    p-inv (+I):      true
    gamma (+G):      true
    both (+I+G):     true
    free rates (+R): false
    fixed freqs:     true
    estimated freqs: true
    #categories:     4
  gamma rates mode:   mean
  asc bias:           none
  epsilon (opt):      0.01
  epsilon (par):      0.05
  keep branches:      false

Additional options:
  verbosity:        very low
  threads:          1/4
  RNG seed:         12345
  subtree repeats:  enabled
--------------------------------------------------------------------------------

BIC       model              K            lnL          score          delta    weight
--------------------------------------------------------------------------------
       1  TIM3+I             7      -892.6505      3230.1662         0.0000    0.6042
       2  TPM3uf+I           6      -896.3858      3231.7152         1.5491    0.2785
       3  TIM3+I+G4          8      -891.8905      3234.5676         4.4015    0.0669
*       4  GTR+I              9      -889.9605      3236.6293         6.4632    0.0239
       5  TIM3+G4            7      -896.1957      3237.2565         7.0903    0.0174
       6  TVM+I              8      -894.7851      3240.3568        10.1907    0.0037
       7  TPM3uf+G4          6      -901.1062      3241.1559        10.9897    0.0025
       8  GTR+I+G4          10      -889.5544      3241.7386        11.5724    0.0019
       9  GTR+G4             9      -893.4938      3243.6959        13.5298    0.0007
      10  TVM+I+G4           9      -894.2053      3245.1189        14.9527    0.0003
--------------------------------------------------------------------------------
Best model according to BIC
---------------------------
Model:              TIM3+I
lnL:                -892.6505
Frequencies:        0.3409 0.1804 0.0549 0.4238
Subst. Rates:       84.5042 2.3740 1.0000 84.5042 64.5939 1.0000 
Inv. sites prop:    0.8268
Gamma shape:        -
Score:              3230.1662
Weight:             0.6042
---------------------------
Parameter importances
---------------------------
P.Inv:              0.9103
Gamma:              0.0206
Gamma-Inv:          0.0691
Frequencies:        1.0000
---------------------------
Model averaged estimates
---------------------------
P.Inv:              0.8317
Alpha:              0.0216
Alpha-P.Inv:        4.9591
P.Inv-Alpha:        0.8245
Frequencies:        0.3384 0.1825 0.0531 0.4259 

Commands:
  > phyml  -i ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta -m 012032 -f m -v e -a 0 -c 1 -o tlr
  > raxmlHPC-SSE3 -s ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta -c 1 -m GTRCATIX -n EXEC_NAME -p PARSIMONY_SEED
  > raxml-ng --msa ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta --model TIM3+I
  > paup -s ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta
  > iqtree -s ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta -m TIM3+I

AIC       model              K            lnL          score          delta    weight
--------------------------------------------------------------------------------
       1  GTR+I              9      -889.9605      2271.9210         0.0000    0.3904
       2  GTR+I+G4          10      -889.5544      2273.1087         1.1877    0.2156
       3  TIM3+I             7      -892.6505      2273.3010         1.3800    0.1958
       4  TIM3+I+G4          8      -891.8905      2273.7809         1.8599    0.1541
       5  TPM3uf+I           6      -896.3858      2278.7717         6.8506    0.0127
       6  GTR+G4             9      -893.4938      2278.9877         7.0666    0.0114
       7  TVM+I              8      -894.7851      2279.5701         7.6491    0.0085
       8  TIM3+G4            7      -896.1957      2280.3913         8.4703    0.0057
       9  TVM+I+G4           9      -894.2053      2280.4106         8.4896    0.0056
      10  TPM3uf+G4          6      -901.1062      2288.2123        16.2913    0.0001
--------------------------------------------------------------------------------
Best model according to AIC
---------------------------
Model:              GTR+I
lnL:                -889.9605
Frequencies:        0.3345 0.1802 0.0624 0.4228
Subst. Rates:       85.8768 4.3984 0.7148 17.5199 59.7800 1.0000 
Inv. sites prop:    0.8268
Gamma shape:        -
Score:              2271.9210
Weight:             0.3904
---------------------------
Parameter importances
---------------------------
P.Inv:              0.6075
Gamma:              0.0172
Gamma-Inv:          0.3753
Frequencies:        1.0000
---------------------------
Model averaged estimates
---------------------------
P.Inv:              0.8271
Alpha:              0.0218
Alpha-P.Inv:        3.9573
P.Inv-Alpha:        0.8116
Frequencies:        0.3376 0.1801 0.0590 0.4232 

Commands:
  > phyml  -i ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta -m 012345 -f m -v e -a 0 -c 1 -o tlr
  > raxmlHPC-SSE3 -s ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta -c 1 -m GTRCATIX -n EXEC_NAME -p PARSIMONY_SEED
  > raxml-ng --msa ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta --model GTR+I
  > paup -s ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta
  > iqtree -s ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta -m GTR+I

AICc      model              K            lnL          score          delta    weight
--------------------------------------------------------------------------------
       1  TPM3uf+I           6      -896.3858      3197.7717         0.0000    0.9825
       2  TPM3uf+G4          6      -901.1062      3207.2123         9.4407    0.0088
       3  TIM3+I             7      -892.6505      3207.3010         9.5294    0.0084
       4  TIM3+G4            7      -896.1957      3214.3913        16.6197    0.0002
       5  TPM1uf+I           6      -905.5473      3216.0946        18.3229    0.0001
       6  TIM3+I+G4          8      -891.8905      3222.7809        25.0092    0.0000
       7  TIM1+I             7      -902.6084      3227.2168        29.4451    0.0000
       8  TVM+I              8      -894.7851      3228.5701        30.7985    0.0000
       9  TPM1uf+G4          6      -911.8302      3228.6603        30.8887    0.0000
      10  TPM1uf+I+G4        7      -906.2149      3234.4299        36.6582    0.0000
--------------------------------------------------------------------------------
Best model according to AICc
---------------------------
Model:              TPM3uf+I
lnL:                -896.3858
Frequencies:        0.3323 0.1885 0.0479 0.4313
Subst. Rates:       83.1921 48.9092 1.0000 83.1921 48.9092 1.0000 
Inv. sites prop:    0.8428
Gamma shape:        -
Score:              3197.7717
Weight:             0.9825
---------------------------
Parameter importances
---------------------------
P.Inv:              0.9910
Gamma:              0.0090
Gamma-Inv:          0.0000
Frequencies:        1.0000
---------------------------
Model averaged estimates
---------------------------
P.Inv:              0.8427
Alpha:              0.0215
Alpha-P.Inv:        5.0061
P.Inv-Alpha:        0.8250
Frequencies:        0.3325 0.1883 0.0480 0.4312 

Commands:
  > phyml  -i ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta -m 012012 -f m -v e -a 0 -c 1 -o tlr
  > raxmlHPC-SSE3 -s ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta -c 1 -m GTRCATIX -n EXEC_NAME -p PARSIMONY_SEED
  > raxml-ng --msa ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta --model TPM3uf+I
  > paup -s ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta
  > iqtree -s ../Bombus_terrestris_dalmatinus-alligned-muscle.fasta -m TPM3uf+I
Done
```


# Visualize mtDNA with Chlorobox with BombusTerresttrismtDNA.gb file in data directory as input

https://chlorobox.mpimp-golm.mpg.de/OGDraw.html

![alt](/Pics/BombusmtDNA.jpg)

# Haplotype Network Distribution color coded by independent samples

```
Rscript Haplonet.R

library(adegenet)
library(ggtree)
library(phangorn)
library(pegas)
library(ggplot2)

dna <- fasta2DNAbin("outfile.fas")

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
legend(x= -63,y=-50, colnames(ind.hap), fill=rainbow(ncol(ind.hap)), cex=0.40, ncol=12, x.intersp=0.3, text.width=11)

```

![alt](/Pics/Haplonet.png)

# MrBayes with Exponential Priors

Download install and make MrBayes

```

git clone --depth=1 https://github.com/NBISweden/MrBayes.git
cd MrBayes
./configure
make 

```

```
library(ape)
data = read.FASTA(file = "outfile.fas",type = "dna")
write.nexus.data(x = data, file = "Bombus_output.nexus",format = "dna")

```


```

#NEXUS
[Data written by write.nexus.data.R, Wed Apr 23 12:11:11 2025]
BEGIN TAXA;
  DIMENSIONS NTAX=120;
  TAXLABELS
    Bayatbadem_16 Bayatbadem_18 Bayatbadem_20 Phaselis_26 Phaselis_28 
    Phaselis_30 Phaselis_4 Phaselis_6 Phaselis_8 Geyikbayir_24 
    Geyikbayir_6 Geyikbayir_2 Geyikbayir_26 Geyikbayir_28 Geyikbayir_4 
    Termessos_18 Termessos_24 Termessos_26 Termessos_6 Firm_70 
    Firm_86 Firm_2 Firm_28 Termessos_1 Termessos_2 
    Termessos_27 Termessos_28 Termessos_29 Termessos_3 Termessos_25 
    Termessos_30 Termessos_7 Termessos_4 Termessos_5 Kumluca_12 
    Kumluca_18 Kumluca_4 Geyikbayir_13 Geyikbayir_23 Geyikbayir_7 
    Demre_7 Demre_8 Kumluca_6 Kumluca_7 Kumluca_5 
    Kumluca_3 Kumluca_28 Kumluca_27 Kumluca_26 Kumluca_25 
    Kumluca_24 Kumluca_23 Kumluca_2 Kumluca_1 Geyikbayir_5 
    Geyikbayir_3 Geyikbayir_27 Geyikbayir_25 Geyikbayir_21 Geyikbayir_1 
    Firm_3 Firm_145 Firm_146 Firm_1 Phaselis_5 
    Phaselis_3 Phaselis_29 Phaselis_27 Phaselis_25 Phaselis_23 
    Phaselis_1 Demre_6 Demre_5 Demre_4 Demre_3 
    Demre_22 Demre_21 Demre_20 Demre_2 Demre_19 
    Demre_18 Demre_17 Demre_16 Demre_1 Bayatbadem_5 
    Bayatbadem_3 Bayatbadem_27 Bayatbadem_25 Bayatbadem_23 Bayatbadem_1 
    Aksu_13 Aksu_3 Aksu_28 Aksu_27 Aksu_25 
    Aksu_2 Aksu_1 Aksu_10 Aksu_12 Aksu_14 
    Aksu_24 Aksu_26 Aksu_4 Aksu_6 Aksu_8 
    Firm_118 Firm_92 Firm_102 Bayatbadem_2 Bayatbadem_26 
    Bayatbadem_28 Bayatbadem_4 Bayatbadem_24 Bayatbadem_6 Phaselis_16 
    Phaselis_2 Firm_32 Firm_58 Firm_78 Firm_82 
    
  ;
END;

BEGIN CHARACTERS;
  DIMENSIONS NCHAR=373;
  FORMAT MISSING=? GAP=- DATATYPE=DNA INTERLEAVE=NO;
  MATRIX
    Bayatbadem_16      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacatattaccggttcctcaaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Bayatbadem_18      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacatattaccggttcctcaaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Bayatbadem_20      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacatattaccggttcctcaaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Phaselis_26        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcatttcattttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Phaselis_28        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcatttcattttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Phaselis_30        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcatttcattttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Phaselis_4         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcatttcattttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Phaselis_6         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcatttcattttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Phaselis_8         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcatttcattttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Geyikbayir_24      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattccaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Geyikbayir_6       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattccaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Geyikbayir_2       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattccaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Geyikbayir_26      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattccaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Geyikbayir_28      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattccaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Geyikbayir_4       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctattaccggttcctccaatcctattcattccaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Termessos_18       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatcgattttattcatttcattttattttaccctttattattttattaatagtatttatacctttaataattttacctattacaggttcctcaaatcctattcattccaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Termessos_24       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatcgattttattcatttcattttattttaccctttattattttattaatagtatttatacctttaataattttacctattacaggttcctcaaatcctattcattccaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Termessos_26       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatcgattttattcatttcattttattttaccctttattattttattaatagtatttatacctttaataattttacctattacaggttcctcaaatcctattcattccaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Termessos_6        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatcgattttattcatttcattttattttaccctttattattttattaatagtatttatacctttaataattttacctattacaggttcctcaaatcctattcattccaaaataaatatttacaaaatcaatttccatccatattttactattaaagatttaatcaccattatttttacatttacaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Firm_70            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattcataatgatacatcaaatcgattttattcacttcactttattttaccatttattattctattaatagtatttatacacttaataattttacatattacaggttcttcacatcctattcactcacaaataaatatttacaaaatcaatttccatccatatttcactattaaagatttaatcaccattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_86            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattcataatgatacatcaaatcgattttattcacttcactttattttaccatttattattctattaatagtatttatacacttaataattttacatattacaggttcttcacatcctattcactcacaaataaatatttacaaaatcaatttccatccatatttcactattaaagatttaatcaccattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_2             ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacatattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_28            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacatattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Termessos_1        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Termessos_2        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Termessos_27       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Termessos_28       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Termessos_29       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Termessos_3        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Termessos_25       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Termessos_30       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Termessos_7        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Termessos_4        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Termessos_5        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_12         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattctattaatagtatttatacatttaataattttacatattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_18         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattctattaatagtatttatacatttaataattttacatattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_4          ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattctattaatagtatttatacatttaataattttacatattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Geyikbayir_13      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Geyikbayir_23      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Geyikbayir_7       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_7            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgataattcttatttgc
    Demre_8            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgataattcttatttgc
    Kumluca_6          ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_7          ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_5          ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_3          ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_28         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_27         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_26         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_25         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_24         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_23         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_2          ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Kumluca_1          ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Geyikbayir_5       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Geyikbayir_3       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Geyikbayir_27      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Geyikbayir_25      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Geyikbayir_21      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Geyikbayir_1       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_3             ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_145           ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_146           ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_1             ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Phaselis_5         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Phaselis_3         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Phaselis_29        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Phaselis_27        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Phaselis_25        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Phaselis_23        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Phaselis_1         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_6            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_5            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_4            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_3            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_22           ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_21           ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_20           ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_2            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_19           ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_18           ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_17           ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_16           ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Demre_1            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Bayatbadem_5       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Bayatbadem_3       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Bayatbadem_27      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Bayatbadem_25      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Bayatbadem_23      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Bayatbadem_1       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_13            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_3             ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_28            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_27            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_25            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_2             ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_1             ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatcgattttattcatttcattttattttaccatttattattttattaatagtatttatacatttaataattttacacattacaggttcttcaaaccctatccattcaaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_10            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttaccccttaccggttcctccaaccccatcccttccaaaataaatatttataaaatccatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_12            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttaccccttaccggttcctccaaccccatcccttccaaaataaatatttataaaatccatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_14            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttaccccttaccggttcctccaaccccatccattccaaaataaatatttataaaatccatttccctccctatttccccattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_24            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttaccccttaccggttcctccaaccccatccattccaaaataaatatttataaaatccatttccctccctatttccccattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_26            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttaccccttaccggttcctccaaccccatccattccaaaataaatatttataaaatccatttccctccctatttccccattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_4             ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttaccccttaccggttcctccaaccccatccattccaaaataaatatttataaaatccatttccctccctatttccccattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_6             ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttaccccttaccggttcctccaaccccattccttccaaaataaatatttacaaaatccatttccctccctatttccccattaaagatttaattactattatttttacatttacaatatttatattaattaatttacaattacctttcatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Aksu_8             ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttaccccttaccggttcctccaaccccatcccttccaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_118           ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttaccccttaccggttcctccaaccccatcccttccaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_92            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttaccccttaccggttcctccaaccccatcccttccaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_102           ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttaccccttaccggttcctccaaccccatcccttccaaaataaatatttataaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Bayatbadem_2       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctcttaccggttcctccaatcccatcccttccaaaataaatatttataaaatccatttccctccctatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Bayatbadem_26      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctcttaccggttcctccaatcccatcccttccaaaataaatatttataaaatccatttccctccctatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Bayatbadem_28      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctcttaccggttcctccaatcccatcccttccaaaataaatatttataaaatccatttccctccctatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Bayatbadem_4       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctcttaccggttcctccaatcccatcccttccaaaataaatatttataaaatccatttccctccctatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Bayatbadem_24      ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctcttaccggttcctccaatcccatcccttccaaaataaatatttataaaatccatttccctccctatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Bayatbadem_6       ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaattaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctcttaccggttcctccaatcccatcccttccaaaataaatatttataaaatccatttccctccctatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Phaselis_16        ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctcttaccggttcctccaatcccatcccttccaaaataaatatttacaaaatccatttccctccctatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Phaselis_2         ttccatatattggtcaatttactgttgaatgaatttgaggaggattttcaatcaataatgatacattaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctcttaccggttcctccaatcccatcccttccaaaataaatatttacaaaatccatttccctccctatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattacctttcatattaagagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatatttcttatttgc
    Firm_32            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattctattaatagtatttatacctttaataattttacctcttacaggttcctccaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatatttcactattaaagatttaattactattatttttacatttacaatatttatattaattaatttacaattacctttcatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_58            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattctattaatagtatttatacctttaataattttacctcttacaggttcctccaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatatttcactattaaagatttaattactattatttttacatttacaatatttatattaattaatttacaattacctttcatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_78            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctcttacaggttcctcaaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
    Firm_82            ttccatatattggtcaatttactgttgaatgaatttgaggaggattttccatccataatgataccttaaatccattttattcctttccttttattttaccctttattattttattaatagtatttatacctttaataattttacctcttacaggttcctcaaatcctattcattcaaaaataaatatttacaaaatcaatttccatccatatttcactattaaagatttaattactattatttttacattttcaatatttatattaattaatttacaattaccttttatattaggagatcctgataattttaaaatagcaaatcctataattacaccaattcatattaaacctgaatgatacttcttatttgc
  ;
END;

begin mrbayes;
	set autoclose = yes;
	lset nst = 2;
	prset statefreqpr = fixed(equal);
	mcmcp nruns = 3 nchains = 1 printfreq = 100;
	mcmc ngen=200000 samplefreq=100;
END;

```

If you read the data matrix in first you can see the current model parameter settings.

```

showmodel

showmodel

   Model settings:

      Data not partitioned --
         Datatype  = DNA
         Nucmodel  = 4by4
         Nst       = 2
                     Transition and transversion  rates, expressed
                     as proportions of the rate sum, have a
                     Beta(1.00,1.00) prior
         Covarion  = No
         # States  = 4
                     State frequencies are fixed to be equal
         Rates     = Equal

   Active parameters: 

      Parameters
      ---------------------
      Tratio              1
      Statefreq           2
      Ratemultiplier      3
      Topology            4
      Brlens              5
      ---------------------

      1 --  Parameter  = Tratio
            Type       = Transition and transversion rates
            Prior      = Beta(1.00,1.00)

      2 --  Parameter  = Pi
            Type       = Stationary state frequencies
            Prior      = Fixed

      3 --  Parameter  = Ratemultiplier
            Type       = Partition-specific rate multiplier
            Prior      = Fixed(1.0)

      4 --  Parameter  = Tau
            Type       = Topology
            Prior      = All topologies equally probable a priori
            Subparam.  = V

      5 --  Parameter  = V
            Type       = Branch lengths
            Prior      = Unconstrained:GammaDir(1.0,0.1000,1.0,1.0)

```



Initialize MrBayes and execute the nexus file

```

mb execute Bombus_output.nexus

```

Running 3 MCMC chains this shows the trace plots of the MCMC chain and reveals a type of convergence.
Run Tracer program on .p file output

```
tracer
```


![alt](/Pics/3MCMC-1.jpg)


The tracer program can show the marginal densities of the sum of the total length of the optimized phylogenetic tree and the ratio of transitions to transversions

![alt](/Pics/TLKAPPAMarginalDens-1.jpg)


![alt](/Pics/CC1.png)

![alt](/Pics/CC2.png)

![alt](/Pics/CC3.png)

![alt](/Pics/CC4.png)

![alt](/Pics/CC5.png)

Estimated Parameter Statistics with 95% confidence intervals and effective samples sizes

![alt](/Pics/95HPD.png)

I also choose to fit a GTR + I general time reversal evolutionary model with invariable sites. The invariable sites assumption means there are particular sites in the sequenece that do not change.



```

lset nst = 6 rate = propinv
mcmcp nruns = 3 nchains = 1 printfreq = 100
mcmc ngen=2000000 samplefreq=100


```

```

showmodel

   Model settings:

      Data not partitioned --
         Datatype  = DNA
         Nucmodel  = 4by4
         Nst       = 6
                     Substitution rates, expressed as proportions
                     of the rate sum, have a Dirichlet prior
                     (1.00,1.00,1.00,1.00,1.00,1.00)
         Covarion  = No
         # States  = 4
                     State frequencies have a Dirichlet prior
                     (1.00,1.00,1.00,1.00)
         Rates     = Propinv
                     Proportion of invariable sites is uniformly dist-
                     ributed on the interval (0.00,1.00).

   Active parameters: 

      Parameters
      ---------------------
      Revmat              1
      Statefreq           2
      Pinvar              3
      Ratemultiplier      4
      Topology            5
      Brlens              6
      ---------------------

      1 --  Parameter  = Revmat
            Type       = Rates of reversible rate matrix
            Prior      = Dirichlet(1.00,1.00,1.00,1.00,1.00,1.00)

      2 --  Parameter  = Pi
            Type       = Stationary state frequencies
            Prior      = Dirichlet

      3 --  Parameter  = Pinvar
            Type       = Proportion of invariable sites
            Prior      = Uniform(0.00,1.00)

      4 --  Parameter  = Ratemultiplier
            Type       = Partition-specific rate multiplier
            Prior      = Fixed(1.0)

      5 --  Parameter  = Tau
            Type       = Topology
            Prior      = All topologies equally probable a priori
            Subparam.  = V

      6 --  Parameter  = V
            Type       = Branch lengths
            Prior      = Unconstrained:GammaDir(1.0,0.1000,1.0,1.0)
```
The transition and transversion substition rate posterior distribution for 1 MCMC run.

![alt](/Pics/SubstitutionDensities-1.jpg) 

The steady state Nucleotide rates for 1 MCMC run.

![alt](/Pics/SteadyStateNucleotidesRates-1.jpg)

The proporiton of invariant sites posterior distribution having a uniform prior.

![alt](/Pics/PropInvSites-1.jpg)

The joint marginal posterior distrubtion sum of tree lengths for all 3 MCMC runs.

![alt](/Pics/JointTreeLengths-1.jpg)

The joint marginal posterior distribution of log likelihoods for all 3 MCMC.

![alt](/Pics/JointLogLik-1.jpg)


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


```
## Show list of available software packages and their versions in your phyluce environment
```
    conda list
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
t_coffee outfile.fas 

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
# ClustalW alignment method
ClustalW is a third generation computer progam used for multiple sequence alignment in bioinformatics. It is claimed to have improved on the progressive alignment method algorithm, which 
computes similarity scores between sequences which produces pairwise alignments. There are set penalties for gaps, but in this case all arguments are set to default because it is such a 
great alignment. After a pairwise matrix if formed a neighbor-joining method is employed to make a guide tree. It is accurate, and consistent when compared against other softwares such as 
MAFFT, and T-Coffee. 
```
clustalw -infile=Desktop/myProject/data/outfile.fas -outfile=Bombus_terrestris_aligned_sequences.fasta -output=fasta
```
## The aligned sequences are independently given per species sequence

# Haplotype R Script
A Haplotype is a group of DNA variations from the cyt b gene that are inherited from a single parent. It comes from the word "haploid" and by examining these haplotypes reserachers 
can identify patterns of genetic variation associated with disease states. In this case its just a Bumble Bee but the principle is the same when studying genetic disease associations. The R-Script produces a haplotype matrix with the rows as haplotype groups, in this case there are 20 unique haplotypes and the columns are the position in the sequence where the change 
between genetic mutation or single nucleotide polymorphism occured.


```
Rscript Haplotypes.R ../data/outfile.fas homolog.csv
```

![alt2](/Pics/homolog-page-2.png)

# Estimating a Distance based phylogenetic tree and Parsimony based phylogenetic tree with R

```
Rscript DistanceBased.R ../data/outfile.fas

```
The RScript computes a pairwise distance matrix from the 120 DNA sequences of the cyt B gene of the Terrestris Bombus using a model of evolution from Tamura (1992). The model assumes
distinct rates for both kinds of transistions A<-->G and C <-->T, and transversions. The base frequencies are estimated and not assumed to be equal. 

![alt](/Pics/DistanceBasedPhylogenies.png)

The Rscript performs the neighbor-joining tree estimation of Saitou and Nei (1987). It takes as an input the distance matrix computed in the previous step.

![alt](/Pics/TerrestrisBombusNJTree.png)


```
Rscript ParsimonyBasedTree.R ../data/outfile.fas

```
In the parsimony based method of computing a phylogenetic tree the parsimony ratchet is a preferred way to search for the best parsimony tree. After returning a parsinomy score
on the initial tree, the optimal parsimony function returns a tree after using NNI rearrangements. 

![alt](/Pics/ParsimonyTree.png)


```
Rscript AssessingQualityofFitNJ.R

```
After using the Neighbor-Joining Method to construct the pairwise distance matrix, we can assess it fit by compaing the original distances in the matrix to the distances found on 
the pylogenetic tree.

![alt](/Pics/NJmethod.png)

![alt](/Pics/NLmethod.png)

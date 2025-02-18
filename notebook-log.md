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

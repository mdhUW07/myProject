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
    conda install bioconda::figtree


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
the pylogenetic tree. The two distance measurements are strongly correlated at 0.9396.

![alt](/Pics/NJmethod.png)


# Unweighted pair group method with Arithmetic Mean

Another method that uses hierarchical clustering taking points from the distances between clusters and distances between two objects in each cluster. Compared to NJ method it has a 
smaller correlation, and not as good of a fit.

![alt](/Pics/UPGMAmethod.png)




# Raxml Maximum Likelihood Tree Construction
Perform an all-in-one analysis (ML tree search + non-parametric bootstrap) (10 randomized parsimony starting trees, fixed empirical substitution matrix (LG), 
empirical aminoacid frequencies from alignment, 8 discrete GAMMA categories, 200 bootstrap replicates):


```
raxml-ng --all -msa Bombus_terrestris_dalmatinus-alligned-muscle.fasta --model LG+G8+F --tree pars{10} --bs-trees 200

```
From the output using figtree downloaded from biocondaview the best fitting phylogenetic tree. If Gimp a photo editing software is downloaded you can open up the tree in a java script
and change the settings to visulalize the tree better/

```

figtree Bombus_terrestris_dalmatinus-alligned-muscle.fasta.raxml.bestTree

```
You can view the initial starting tree and the best tree

![alt](/Pics/Bombus_terrestris_dalmatinus-alligned-muscle.fasta.raxml.startTree.jpg)

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

WARNING: Sequences Bayatbadem_2 and Bayatbadem_26 are exactly identical!
WARNING: Sequences Bayatbadem_2 and Bayatbadem_28 are exactly identical!
WARNING: Sequences Bayatbadem_2 and Bayatbadem_4 are exactly identical!
WARNING: Sequences Bayatbadem_2 and Bayatbadem_24 are exactly identical!
WARNING: Sequences Bayatbadem_2 and Bayatbadem_6 are exactly identical!
WARNING: Sequences Phaselis_16 and Phaselis_2 are exactly identical!
WARNING: Sequences Aksu_14 and Aksu_24 are exactly identical!
WARNING: Sequences Aksu_14 and Aksu_26 are exactly identical!
WARNING: Sequences Aksu_14 and Aksu_4 are exactly identical!
WARNING: Sequences Aksu_10 and Aksu_12 are exactly identical!
WARNING: Sequences Aksu_8 and Firm_118 are exactly identical!
WARNING: Sequences Aksu_8 and Firm_92 are exactly identical!
WARNING: Sequences Firm_32 and Firm_58 are exactly identical!
WARNING: Sequences Bayatbadem_16 and Bayatbadem_18 are exactly identical!
WARNING: Sequences Bayatbadem_16 and Bayatbadem_20 are exactly identical!
WARNING: Sequences Geyikbayir_24 and Geyikbayir_6 are exactly identical!
WARNING: Sequences Geyikbayir_24 and Geyikbayir_2 are exactly identical!
WARNING: Sequences Geyikbayir_24 and Geyikbayir_26 are exactly identical!
WARNING: Sequences Geyikbayir_24 and Geyikbayir_28 are exactly identical!
WARNING: Sequences Geyikbayir_24 and Geyikbayir_4 are exactly identical!
WARNING: Sequences Phaselis_26 and Phaselis_28 are exactly identical!
WARNING: Sequences Phaselis_26 and Phaselis_30 are exactly identical!
WARNING: Sequences Phaselis_26 and Phaselis_4 are exactly identical!
WARNING: Sequences Phaselis_26 and Phaselis_6 are exactly identical!
WARNING: Sequences Phaselis_26 and Phaselis_8 are exactly identical!
WARNING: Sequences Termessos_18 and Termessos_24 are exactly identical!
WARNING: Sequences Termessos_18 and Termessos_26 are exactly identical!
WARNING: Sequences Termessos_18 and Termessos_6 are exactly identical!
WARNING: Sequences Firm_2 and Firm_28 are exactly identical!
WARNING: Sequences Firm_78 and Firm_82 are exactly identical!
WARNING: Sequences Termessos_1 and Termessos_2 are exactly identical!
WARNING: Sequences Termessos_1 and Termessos_27 are exactly identical!
WARNING: Sequences Termessos_1 and Termessos_28 are exactly identical!
WARNING: Sequences Termessos_1 and Termessos_29 are exactly identical!
WARNING: Sequences Termessos_1 and Termessos_3 are exactly identical!
WARNING: Sequences Termessos_1 and Termessos are exactly identical!
WARNING: Sequences Termessos_1 and Termessos_30 are exactly identical!
WARNING: Sequences Termessos_1 and Termessos_7 are exactly identical!
WARNING: Sequences Termessos_1 and Termessos_4 are exactly identical!
WARNING: Sequences Termessos_1 and Termessos_5 are exactly identical!
WARNING: Sequences Firm_70 and Firm_86 are exactly identical!
WARNING: Sequences Kumluca_12 and Kumluca_18 are exactly identical!
WARNING: Sequences Kumluca_12 and Kumluca_4 are exactly identical!
WARNING: Sequences Geyikbayir_13 and Geyikbayir_23 are exactly identical!
WARNING: Sequences Geyikbayir_13 and Geyikbayir_7 are exactly identical!
WARNING: Sequences Demre_7 and Demre_8 are exactly identical!
WARNING: Sequences Kumluca_6 and Kumluca_7 are exactly identical!
WARNING: Sequences Kumluca_6 and Kumluca_5 are exactly identical!
WARNING: Sequences Kumluca_6 and Kumluca_3 are exactly identical!
WARNING: Sequences Kumluca_6 and Kumluca_28 are exactly identical!
WARNING: Sequences Kumluca_6 and Kumluca_27 are exactly identical!
WARNING: Sequences Kumluca_6 and Kumluca_26 are exactly identical!
WARNING: Sequences Kumluca_6 and Kumluca_25 are exactly identical!
WARNING: Sequences Kumluca_6 and Kumluca_24 are exactly identical!
WARNING: Sequences Kumluca_6 and Kumluca_23 are exactly identical!
WARNING: Sequences Kumluca_6 and Kumluca_2 are exactly identical!
WARNING: Sequences Kumluca_6 and Kumluca_1 are exactly identical!
WARNING: Sequences Kumluca_6 and Geyikbayir_5 are exactly identical!
WARNING: Sequences Kumluca_6 and Geyikbayir_3 are exactly identical!
WARNING: Sequences Kumluca_6 and Geyikbayir_27 are exactly identical!
WARNING: Sequences Kumluca_6 and Geyikbayir_25 are exactly identical!
WARNING: Sequences Kumluca_6 and Geyikbayir_21 are exactly identical!
WARNING: Sequences Kumluca_6 and Geyikbayir_1 are exactly identical!
WARNING: Sequences Kumluca_6 and Firm_3 are exactly identical!
WARNING: Sequences Kumluca_6 and Firm_145 are exactly identical!
WARNING: Sequences Kumluca_6 and Firm_146 are exactly identical!
WARNING: Sequences Kumluca_6 and Firm_1 are exactly identical!
WARNING: Sequences Kumluca_6 and Phaselis_5 are exactly identical!
WARNING: Sequences Kumluca_6 and Phaselis_3 are exactly identical!
WARNING: Sequences Kumluca_6 and Phaselis_29 are exactly identical!
WARNING: Sequences Kumluca_6 and Phaselis_27 are exactly identical!
WARNING: Sequences Kumluca_6 and Phaselis_25 are exactly identical!
WARNING: Sequences Kumluca_6 and Phaselis_23 are exactly identical!
WARNING: Sequences Kumluca_6 and Phaselis_1 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_6 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_5 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_4 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_3 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_22 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_21 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_20 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_2 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_19 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_18 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_17 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_16 are exactly identical!
WARNING: Sequences Kumluca_6 and Demre_1 are exactly identical!
WARNING: Sequences Kumluca_6 and Bayatbadem_5 are exactly identical!
WARNING: Sequences Kumluca_6 and Bayatbadem_3 are exactly identical!
WARNING: Sequences Kumluca_6 and Bayatbadem_27 are exactly identical!
WARNING: Sequences Kumluca_6 and Bayatbadem_25 are exactly identical!
WARNING: Sequences Kumluca_6 and Bayatbadem_23 are exactly identical!
WARNING: Sequences Kumluca_6 and Bayatbadem_1 are exactly identical!
WARNING: Sequences Kumluca_6 and Aksu_13 are exactly identical!
WARNING: Sequences Kumluca_6 and Aksu_3 are exactly identical!
WARNING: Sequences Kumluca_6 and Aksu_28 are exactly identical!
WARNING: Sequences Kumluca_6 and Aksu_27 are exactly identical!
WARNING: Sequences Kumluca_6 and Aksu_25 are exactly identical!
WARNING: Sequences Kumluca_6 and Aksu_2 are exactly identical!
WARNING: Sequences Kumluca_6 and Aksu_1 are exactly identical!
WARNING: Duplicate sequences found: 100

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

# Find the best model fit based on the maximum likelihood estimation procedure.


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
       4  GTR+I              9      -889.9605      3236.6293         6.4632    0.0239
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




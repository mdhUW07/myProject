### Create Github class respository assignment

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

# Make a parent directory and name it miniconda3
```
    mkdir -p ~/miniconda3
```
# Use wget command to download from source package online
```
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
```
# Run the shell script by invoking bash command on the executable bash file
```    
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
```
# Remove the bash file
```
    rm ~/miniconda3/miniconda.sh
```
# Check which version you have installed
```
    which conda
```
# Which python version
```
    which python -V
```
# Create conda environment
```
    conda create --name phyluce phyluce
```
# Activate the environment
```
    conda activate phyluce
```
# Install t_coffee alignment software from bioconda channel
```
    conda install bioconda::t_coffee
```
# Show list of available software packages and their versions in your phyluce environment
```
    conda list
```

### Aligning my data with t_coffee
Multiple sequence alignment of the cyt b sequences is a prerequesite for phylogentic analysis. T_coffee is a free open source software used for multiple sequence alignment, which
progressivley optimizes the alignment based on pairwise alignments that is comparable to another software ClustalW. I will include a script of the command lines necessary to achieve the 
progressive alginment after prerequisite software has been downloaded to the operating system of your choice. In the data directory a master source file from which all downstream analysis
start is the first argument for running the t_coffee multiple sequence alignment software. One of the weaknesses of t-coffee is the complexity of user parameter specifications which may
require a deeper understanding of the underlying algorithms. In order to achieve an optimum alignment knowledge of how these different parameter specifications work depending on the specific data set and goals.  

t_coffee outfile.fas 


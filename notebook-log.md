#Create Github class respository assignment

120 mitochondrial cyt b sequences of B. terrestris dalmatinus.
The files are in multiple sequences
FASTA format file and the dataset is about
the mitochondrial cytochrome b gene 
sequences and are 373 base pairs in length
and were collected from 8 different beehives
in Antalya. Because the files are in FASTA format, not FASTQ, there are no
quality control measures per base read, therefore, 
I do not believe a quality control step is necessary.

#Aligning my data with t_coffee
Multiple sequence alignment of the cyt b sequences is a prerequesite for phylogentic analysis. T_coffee is a free open source software used for multiple sequence alignment, which
progressivley optimizes the alignment based on pairwise alignments that is comparable to another software ClustalW. I will include a script of the command lines necessary to achieve the 
progressive alginment after prerequisite software has been downloaded to the operating system of your choice. 

t_coffee outfile.fas 


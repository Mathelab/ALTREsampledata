##Need to make a file of Transcription Start Sites (TSS) for ALTRE *getTSS* function?##

The *getTSS()* function requires the transcription start sites to be in the following format: chr, start, stop, gene_name. A gtf is not in this format, and may contain additional information besides TSS, such as intron start and stop sites. These need to be filtered out. 

The perl file available in this folder converts a human hg19 gtf file to a bed file -- usable with the ALTRE R package (in the *getTSS* function). 

The gtf file is too large to host on a github free repository. 
The gtf file can be download here: ftp://ftp.ensembl.org/pub/release-75/gtf/homo_sapiens/Homo_sapiens.GRCh37.75.gtf.gz

How to run the script:

perl ./gtftobed_human.pl [inputgtf] [outputfile]

perl ./gtftobed_human.pl Homo_sapiens.GRCh37.75.gtf Homo_sapiens.GRCh37.75_exon1only.bed

The script is customized to this gtf file. It is extremely unlikely to work on a gtf file of another species or even a different human build. 

However, with minor modifications (on your part!) it can tackle other gtf files and so it is a good starting place. 


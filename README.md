
Pre-install (System Requirements)

	1. A computer with a Unix/Linux operating system
	2. bwa samtools bedtools(bamToBed) perl

To run this script you need the following data

	1. A fasta format file containing the reference genome sequence
	2. A male-specific NGS in fasta/fastq format double-ended data (Preferably fastq)  
	3. A female-specific NGS in fasta/fastq format double-ended data (Preferably fastq)
	The final files you should have are the following five files:
		genome malereads1 malereads2 femalereads1 femalereads2

Example: 

	pipeline_identified_ZWcontigs.pl genome malereads1 malereads2 femalereads1 femalereads2
		(The file parameters must be in order)

Output file

	1.The final output contains two important fasta sequence files, W and Z, with the file names $genome_Z.fa $genome_W.fa
	($genome depending on your genome file name)

If you have any questions, you can ask them on GitHub and send us an email at luochaorui_swu@126.com

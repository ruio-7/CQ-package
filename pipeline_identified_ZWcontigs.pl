#!usr/bin/perl
#perl pipeline_identified_ZWcontigs.pl genome malereads1 malereads2 femalereads1 femalereads2
my ($genome,$malereads1,$malereads2,$femalereads1,$femalereads2)=@ARGV;
system"bwa index -a bwtsw $genome";
system"bwa mem -t 50 $genome $malereads1 $malereads2 >$genome\_Male.sam";
system"bwa mem -t 50 $genome $femalereads1 $femalereads2 >$genome\_Female.sam";
system"samtools view -b -o $genome\_Male.bam $genome\_Male.sam";
system"samtools view -b -o $genome\_Female.bam $genome\_Female.sam";
system"samtools view -@ 50 -bq 1 $genome\_Male.sam >$genome\_Male_uniq.bam";
system"samtools view -@ 50 -bq 1 $genome\_Female.sam >$genome\_Female_uniq.bam";
system"bamToBed -i $genome\_Male_uniq.bam >$genome\_Male_uniq.bed";
system"bamToBed -i $genome\_Female_uniq.bam >$genome\_Female_uniq.bed";
system"perl counts_CQ-Reads2.pl $genome\_Male_uniq.bed $genome\_Male_uniq_Reads.tab";
system"perl counts_CQ-Reads2.pl $genome\_Female_uniq.bed $genome\_Female_uniq_Reads.tab";
system"perl calculate_CQ_and_extraZW_seq.pl $genome $genome\_Male_uniq_Reads.tab $genome\_Female_uniq_Reads.tab";
system"rm $genome\_Male.sam $genome\_Female.sam $genome\_Male_uniq.bam $genome\_Female_uniq.bam";

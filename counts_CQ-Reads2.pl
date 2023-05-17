#!/usr/bin/perl

my ($bed_file,$out_file)=@ARGV;
my @ID;
open OUT, ">$out_file" or die"Can't open the output file: $!\n";
open BED, "$bed_file" or die"Can't open the bed file: $!\n";
while(<BED>){
      	chomp;
      	my $line=$_;
      	$line=~s/ +/\t/g;
      	my @bed_line=split("\t",$line);
      	push @ID,$bed_line[0]; 	
    }
close BED;


$hash{$_}++ for @ID; print OUT "$_\t$hash{$_}\n" for (keys %hash);

close OUT;
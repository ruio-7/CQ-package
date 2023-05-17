#!usr/bin/perl
my($genome,$McontigReadsNum,$FcontigReadsNum)=@ARGV;

#####estimate corrected factor######################
my $totalMUniqReads=0;
my $totalFUniqReads=0;
my $CorrextFactore=0;
my @Mlines;
my @Flines;
my @AllFcontigs;
my @AllZcontigs;
my @AllWcontigs;

open MRN,"$McontigReadsNum" or die "cannot open male contig mapped unique Reads number";
while(<MRN>){
	chomp;
	push @Mlines,$_;
	my ($Mcontig,$Mreads)=split("\t",$_);
	$totalMUniqReads=$totalMUniqReads+$Mreads;
	}
close MRN;

open FRN,"$FcontigReadsNum" or die "cannot open female contig mapped unique Reads number";
while(<FRN>){
	chomp;
	push @Flines,$_;
	my ($Fcontig,$Freads)=split("\t",$_);
	$totalFUniqReads=$totalFUniqReads+$Freads;
	push @AllFcontigs,$Fcontig;
	}
close FRN;

 $CorrextFactore=$totalMUniqReads/$totalFUniqReads;

 for(@AllFcontigs){
 	    my $SpeContig=$_;
 	    my $SpeContigMreads=0;
 	    my $SpeContigFreads=0;
 	    my $CQvalue=0;
 	  
 	  foreach(@Mlines){
 	  	my($Mele1,$Mele2)=split("\t",$_);
 	  	if ($SpeContig eq $Mele1){$SpeContigMreads=$Mele2;}
 	  	}
 	  	
 	  foreach(@Flines){
 	  	my($Fele1,$Fele2)=split("\t",$_);
 	  	if ($SpeContig eq $Fele1){$SpeContigFreads=$Fele2;}
 	  	} 	
 	  	
 	  $CQvalue=$SpeContigMreads/($SpeContigFreads*$CorrextFactore);
 	  if($CQvalue>1.7){push @AllZcontigs,$SpeContig;}
 	  if($CQvalue<0.3){push @AllWcontigs,$SpeContig;}
 	}


#################extract sequences####################
open SEQ, "$genome" or die "Can't open the genome file: $!\n";
open ZSEQ,">$genome\_Z\.fa" or die "Can't open the Z contigs file: $!\n";
open WSEQ,">$genome\_W\.fa" or die "Can't open the W contigs file: $!\n";
  $/="\>";<SEQ>;
   while (<SEQ>) {
         chomp; 
	     my ($head,$seq)=split("\n",$_,2);
            $seq=~s/\n//g; $seq=~s/>//g;
	 
	 foreach  (@AllZcontigs) {
		       my $eachzID=$_;
		       if ($head eq $eachzID) {print ZSEQ ">$head\n$seq\n";}
	       }
	foreach  (@AllWcontigs) {
		       my $eachwID=$_;
		       if ($head eq $eachwID) {print WSEQ ">$head\n$seq\n";}
	       } 
	  
	}
close SEQ;
close ZSEQ;
close WSEQ;



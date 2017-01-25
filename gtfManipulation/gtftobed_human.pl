#!/usr/bin/perl
# Small script that takes in a CSV file of TSS (e.g. ENSEMBL) and will output a list of TSS in BED format
# Starting position is zero based, end position is one based
# Created 06/29/12 by Ewy Mathe
# Edited 11/02/15 by Elizabeth Baskin 
use strict;
use warnings;
use Pod::Usage;

pod2usage("Usage: $0 ensembl.csv tss.bed") if ((@ARGV != 2));

# Open files
open(my $ref, "<", $ARGV[0]) or die "Can't open $ARGV[0] $!!";
open(my $out, ">", $ARGV[1]) or die "Can't open $ARGV[1] $!";
print $out "chr\tstart\tstop\tgenename\texon_number\tgeneid\ttranscriptid\texon\ttranscriptname\tstrand\n";

#we will be making a hash of arrays below 
my %tss; #hash that keeps track of tss

#skip the first 5 lines 
<$ref>;
<$ref>;
<$ref>;
<$ref>;
<$ref>;

while(<$ref>) {
	#remove new lines and other end of line characters 
	chomp($_);

	$_ =~ s/;/,/g;
	$_ =~ s/ //g;
	$_ =~ s/\t/,/g;
	#seperate the lines by a comma 
	my @fields = split(/,/,$_);
	
	#place fields in variables for easier readability
	my $category = $fields[2];
    my $exonnumber = $fields[10];
    my $strand = $fields[6];
	my $chrom = $fields[0];
    my $start = $fields[3];
    my $stop = $fields[4];
    my $gene = $fields[8];
    my $transc = $fields[9];
    my $genename = $fields[11];
    my $transcname = $fields[14];
     
	

    #If the strand is equal to a plus sign (positive strand), a numeric chromosome, and exon number 1
    if ($strand eq "+" && $category eq "exon" && $exonnumber eq 'exon_number"1"') {
    
        my @tssarray = ($chrom, $start, $strand, $gene, $transc, $genename, $transcname, $category, $exonnumber);
        if (exists $tss{($gene."_".$transc)}) {
			next;
		}
        #if this transcript already exists in the hash skip 
        else {
			$tss{($gene."_".$transc)}=\@tssarray;
            print $out $chrom."\t".$start."\t".($start+1)."\t".$genename."\t".$exonnumber."\t".$gene."\t".$transc."\t".$category."\t".$transcname."\t".$strand."\n"
		#otherwise, this transcript does not exist in the hash so add it and print the info we want to the out file
        }
	}
	elsif ($strand eq "-" && $category eq "exon" && $exonnumber eq 'exon_number"1"') {
		##If the strand is equal to a negative sign (negative strand), a numeric chromosome, and exon number 1
        my @tssarray = ($chrom, $stop-1, $strand, $gene, $transc, $genename, $transcname, $category, $exonnumber);
     if (exists $tss{($gene."_".$transc)}) {
			next;
		}
        #if this transcript already exists in the hash skip 
        else {
			$tss{($gene."_".$transc)}=\@tssarray;
            print $out $chrom."\t".($stop-1)."\t".($stop)."\t".$genename."\t".$exonnumber."\t".$gene."\t".$transc."\t".$category."\t".$transcname."\t".$strand."\n"
		#otherwise, this transcript does not exist in the hash so add it and print the info we want to the out file
        }
	}
    else { next;}
    #go to the next line  
}
    



close($ref) or die "Can't close $ref\n";
close($out) or die "Can't close $out\n";
#close the files 
exit;

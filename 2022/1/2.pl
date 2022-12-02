#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my $index = 0;
my @elves = ();

my $most = 0;
while (<>) {
    chomp;
    
    if (!$_) {
        if ($elves[$index] > $elves[$most]) {
           $most = $index; 
        }
        $index++;
    }
    else {
        $elves[$index] += $_;
    }
}

my @sorted = sort {$a <=> $b} @elves;
my $sum;
foreach my $i (@sorted[-3 .. -1]) {
    $sum += $i;
}
say $sum;





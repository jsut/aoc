#!/usr/bin/env perl
use 5.40.0;
use strict;

my @one;
my %two;


while (<>) {
    chomp;
    my ($one, $two) = split(/\s+/, $_);

    push @one, $one;
    $two{$two}++;
}


my $sum;

while (my $one = shift @one){

    $sum += $one * $two{$one}


}

say $sum;






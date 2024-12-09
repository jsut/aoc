#!/usr/bin/env perl
use 5.40.0;
use strict;

my @one;
my @two;


while (<>) {
    chomp;
    my ($one, $two) = split(/\s+/, $_);

    push @one, $one;
    push @two, $two;
}

my @sone = sort {$a <=> $b} @one;
my @stwo = sort {$a <=> $b} @two;

my $sum;

while (my $one = shift @sone){
    my $two =shift @stwo;
    $sum += abs($one - $two);


    say qq[$one, $two];
}

say $sum;






#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my @input = split /,/, "12,20,0,6,1,17,7";

my $i = 0;
my %last_spoken;
my $starting_list = scalar @input - 1;

while (@input) {
    my $num = shift @input;
    say "$i: $num";
    if ($i >= $starting_list) {
        if (exists $last_spoken{$num}) {
            push @input, $i - $last_spoken{$num};
        }
        else {
            push @input, 0;
        }
    }
    $last_spoken{$num} = $i;
    $i++;
    if ($i >= 30000000) {
        last;
    }
}




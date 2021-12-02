#!/usr/bin/env perl
use 5.18.4;
use strict;

my $h = 0;
my $d = 0;

while (<>) {
    chomp;
    my @bits = split / /;

    if ($bits[0] eq 'forward') {
        $h += $bits[1];  
    }
    elsif ($bits[0] eq 'down') {
        $d += $bits[1];
    }
    elsif ($bits[0] eq 'up') {
        $d -= $bits[1];
    }
}

say $d * $h;



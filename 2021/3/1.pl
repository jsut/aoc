#!/usr/bin/env perl
use 5.18.4;
use strict;

my @sums;
my $rows;

while (<>) {
    chomp;
    my @bits = split // ;

    for(my $i=0;$i<@bits;$i++) {
        $sums[$i]+=$bits[$i]
    }
    $rows++;
}

say join ',', @sums;

my $gamma = join '', map { int ((2 * $_) / $rows) } @sums;
my $epsilon = $gamma;
$epsilon =~ tr/01/10/;

say oct("0b$gamma") * oct("0b$epsilon");







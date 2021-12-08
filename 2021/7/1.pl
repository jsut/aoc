#!/usr/bin/env perl
use 5.18.4;
use strict;

use List::Util qw/reduce/;

my @positions;

while (<>) {
    chomp;
    @positions = split ',';
}


sub calc_fuel {
    my ($positions, $target) = @_;
    my $cost;
    foreach my $pos (@$positions) {
        $cost += abs($pos - $target);
    }
    return $cost;
}

my $sum = reduce { $a + $b } @positions;
my $started_at = int($sum / @positions);
my $trying = $started_at;
my $lowest = calc_fuel(\@positions, $trying);

my $up = 1;

while (1) {
    say 'trying: ', $trying;
    my $try = calc_fuel(\@positions, $trying);
    say 'fuel: ', $try;
    say 'up: ', $up;

    if ($try > $lowest) {
        if (!$up) {
            last;
        }
        $up = 0;
        $trying = $started_at;
    }
    else {
        $lowest = $try;
        $trying = $up ? $trying+1 : $trying-1;

    }
}
say $trying;
say $lowest;

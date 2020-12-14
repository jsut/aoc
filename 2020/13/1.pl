#!/usr/bin/env perl
use 5.18.4;
use strict;


my $earliest = <>;
my $sched = <>;
chomp $earliest;
chomp $sched;

say $earliest;
say $sched;

my @buses = split ',', $sched;

my $min;
my $min_bus;
foreach my $bus (@buses) {
    next if $bus eq 'x';
    my $rem = $bus - ($earliest % $bus);
    say "$bus: $rem";
    if ($rem < $min || !$min) {
        $min_bus = $bus;
        $min = $rem;
    }
}

say $min_bus * $min;


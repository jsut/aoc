#!/usr/bin/env perl
use 5.18.4;
use strict;

use List::Util qw/reduce/;

my @entries;

my $ld;
my $count;

while (<>) {
    chomp;
    push @entries, $_;
    say $_;

    my $depth;

    if (@entries >= 3) {
        $depth = reduce {$a + $b } @entries[ -3..-1];
    }
    say "  ", $depth , " " , $ld;

    if ($ld && $depth > $ld) {
        $count++;
    }

    if ($depth) {
        $ld = $depth;
    }
}

say ' count ', $count;




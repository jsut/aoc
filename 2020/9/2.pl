#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;
use List::Util qw/sum min max/;

my $val = 90433990;

my @set;
my @list;

while (<>) {
    chomp;
    push @list, $_;
}

while (@set || @list) {
    my $sum = sum(@set);
    if (@list && $sum < $val) {
        say 'adding to @set';
        push @set, shift @list;
    }
    say $sum;
    say $val;
    if ($val == $sum){
        last;
    }
    if ($sum < $val) {
        say 'too small'
    }
    if ($sum > $val) {
        say 'dropping from @set';
        shift @set;
    }
}

say 'wassup';
say min(@set) + max(@set);


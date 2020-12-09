#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my @prev;

sub gen_sums {
    my %sums;
    foreach my $i (@prev) {
       foreach my $j (@prev) {
           $sums{$i+$j}++
       }
    }
    return \%sums;
}

my $preamble_done;
while (<>) {
    chomp;
    say;
    my $sums = gen_sums();
    if ( $preamble_done && !$sums->{$_}) {
        say Dumper $sums;
        say Dumper \@prev;
        say $_;
        last;
    }
    push @prev, $_;
    if (scalar @prev > 25) {
        say 'dropping something from list';
        shift @prev;
        $preamble_done = 1;
    }
}




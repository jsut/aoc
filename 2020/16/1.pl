#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my $input_state;
my @ticket;
my @nearby;

my %options;

while (<>) {
    chomp;

    if ($_ eq '') {
        $input_state++;
        next;
    }

    if (!$input_state) {
        my ($class, $range1s, $range1e,$range2s, $range2e) = $_ =~ m/^([^:]+): (\d+)-(\d+) or (\d+)-(\d+)$/;

        foreach my $i ($range1s..$range1e, $range2s..$range2e) {
            if (!$options{$i}) {
                $options{$i} = []
            }
            push @{$options{$i}}, $class;
        }
    }
    elsif($input_state == 1 && $_ ne 'your ticket:') {
        @ticket = split ',', $_;

    }
    elsif($input_state == 2 && $_ ne 'nearby tickets:') {
        my @near = split ',', $_;
        push @nearby, \@near;
    }
}

say Dumper \%options;
my $sum;

for my $i (@nearby) {
    for my $j (@$i) {
        if (!$options{$j}) {
            $sum += $j;
        }
    }
}

say $sum;



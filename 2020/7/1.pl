#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my %tree;

while (<>) {
    chomp;
    s/.$//;

    my ($bag,$rules) = split ' contain ';
    $bag =~ s/ bags?$//g;

    my @rules = split ', ', $rules;
    $tree{$bag} = {};

    foreach my $thing (@rules) {
        my ($q, @rest) = split ' ', $thing;
        my $ha = join ' ', @rest;
        $ha =~ s/ bags?$//g;
        $tree{$bag}{$ha} = $q;
    }
}

say Dumper \%tree;

my $count = 0;

my %seen;

my @bag_types = ('shiny gold');
while (@bag_types) {
    my $bag_type = pop @bag_types;
    say "what can contain $bag_type";
    foreach my $bag (keys %tree) {
        #say "checking $bag can contain $bag_type";
        if ($tree{$bag}{$bag_type}) {
            if (!$seen{$bag}) {
                say "!!$bag can contain $bag_type";
                $seen{$bag}++;
                $count++;
                push @bag_types, $bag;
            }
        }
    }
}

say $count;




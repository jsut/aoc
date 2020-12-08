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
    next if $rules eq 'no other bags';

    foreach my $thing (@rules) {
        my ($q, @rest) = split ' ', $thing;
        my $ha = join ' ', @rest;
        $ha =~ s/ bags?$//g;
        $tree{$bag}{$ha} = $q;
    }
}

say Dumper \%tree;

my $count = 0;

my @bag_types = ({type => 'shiny gold', q => 1});
while (@bag_types) {
    my $bag_details = pop @bag_types;
    my $bag_type = $bag_details->{'type'};
    my $q = $bag_details->{q};
    say "we have $q $bag_type";
    $count += $q;
    foreach my $bag (keys %{$tree{$bag_type}}) {
        say "each $bag_type contains $tree{$bag_type}{$bag} $bag";
        push @bag_types, {
            type => $bag,
            q => $q * $tree{$bag_type}{$bag}
        };
    }
    say "$count so far";
}

$count--; #don't count the first shiny bag

say $count;




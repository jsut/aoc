#!/usr/bin/env perl
use 5.18.4;
use strict;
use List::Util qw/reduce/;
use Data::Dumper;

my @state;
my $fishes = {};

while (<>) {
    chomp;
    @state = split ',';
    foreach my $num (@state) {
        $fishes->{$num}++;
    }
}

sub day {
    my $fishes = shift;
    my $new_fishes;

    $new_fishes->{0} = $fishes->{1};
    $new_fishes->{1} = $fishes->{2};
    $new_fishes->{2} = $fishes->{3};
    $new_fishes->{3} = $fishes->{4};
    $new_fishes->{4} = $fishes->{5};
    $new_fishes->{5} = $fishes->{6};
    $new_fishes->{6} = $fishes->{0} + $fishes->{7};
    $new_fishes->{7} = $fishes->{8};
    $new_fishes->{8} = $fishes->{0};
    return $new_fishes;
}

foreach my $day (0..255) {
    $fishes = day($fishes);
}

say reduce { $a + $b } values %$fishes;




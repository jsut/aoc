#!/usr/bin/env perl
use 5.18.4;
use strict;
use List::MoreUtils 'first_index';

my $sum;
my @values = ('a'..'z','A'..'Z');

while (<>) {
    chomp;
    my @items = split '';
    my $comp = ();
    say join ',',@items;
    for (my $i =0; $i < @items; $i++) {
        if ($i > (@items - 1) / 2) {
            say $items[$i] . ' in second';
            if ($comp->{$items[$i]}) {
                say $items[$i];
                $sum += (first_index {$_ eq $items[$i]} @values) + 1;
                say $sum;
                last;
            }
        }
        else {
            say $items[$i] . ' in first';
            $comp->{$items[$i]}++;
        }
    }
}

say $sum;




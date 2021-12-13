#!/usr/bin/env perl
use 5.18.4;
use strict;

my $count;

my $values = {
    2 => 1,
    3 => 1,
    4 => 1,
    7 => 1,
};

while (<>) {
    chomp;
    my ($input_string, $output_string) = split '\|';
    my @output = split ' ', $output_string;
    foreach my $string (@output) {
        if ($values->{length($string)}) {
            $count++;
        }
    }
}

say $count;


#!/usr/bin/env perl
use 5.18.4;
use strict;

my $braces = {
    '{' => '}',
    '[' => ']',
    '(' => ')',
    '<' => '>',
};

my $points = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137,
};

my $sum;

while (<>) {
    chomp;
    my @bits = split '';
    my @unmatched;
    my $corrupted;
    say $_;
    foreach my $bit (@bits) {
        if ($braces->{$bit}) {
            push @unmatched, $bit;
        }
        elsif ($braces->{@unmatched[-1]} eq $bit) {
            pop @unmatched;
        }
        else {
            $corrupted++;
            $sum += $points->{$bit};
            last;
        }
    }
    say $corrupted ? 'corrupted' : 'ok';

}


say $sum;

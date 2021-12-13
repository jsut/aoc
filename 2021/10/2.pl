#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my $braces = {
    '{' => '}',
    '[' => ']',
    '(' => ')',
    '<' => '>',
};

my $points = {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4,
};

my @scores;

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
            last;
        }
    }
    if (!$corrupted) {
        my $score;
        while (@unmatched) {
            my $bit = pop @unmatched;
            say $bit;
            $score *= 5;
            $score += $points->{$braces->{$bit}};
        }        
        push @scores, $score;
    }
}

@scores = sort {$a <=> $b} @scores;
say Dumper \@scores;

say $scores[int(@scores/2)]

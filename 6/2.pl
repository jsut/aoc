#!/usr/bin/env perl
use 5.18.4;
use strict;

my %q;
my $sum = 0;
my $people = 0;

while (<>) {
    chomp;
    say;

    if (!$_) {
        my $count = 0;
        foreach my $key (keys(%q)) {
            if ($people == $q{$key}) {
                $count++;
            }
        }
        say 'count';
        say $people;
        say $count;
        $sum = $sum + $count;
        %q = ();
        $people = 0;
        next;
    }
    $people++;
    foreach my $char (split //) {
        $q{$char}++;
    }
}

say 'total';
say $sum;



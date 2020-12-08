#!/usr/bin/env perl
use 5.18.4;
use strict;

my %q;
my $sum = 0;

while (<>) {
    chomp;
    say;

    if (!$_) {
        my $count = keys(%q);
        say 'wassup';
        say $count;
        say $sum;
        $sum = $sum + $count;
        %q = ();
        next;
    }

    foreach my $char (split //) {
        $q{$char}++;
    }
}

say 'total';
say $sum;



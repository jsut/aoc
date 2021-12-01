#!/usr/bin/env perl
use 5.18.4;
use strict;

my $current;
my $count = 0;

while (<>) {
    chomp;
    if (!$current) {
      $current = $_;
    }

    if ($_ > $current) {
      $count++;
    }

    $current = $_;
}

say $count;




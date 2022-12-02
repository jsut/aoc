#!/usr/bin/env perl
use 5.18.4;
use strict;

my $pp = {
  X => 1,
  Y => 2,
  Z => 3,
};
my $gp = {
  A => {
    X => 3,
    Y => 6,
    Z => 0,
  },
  B => {
    X => 0,
    Y => 3,
    Z => 6,
  },
  C => {
    X => 6,
    Y => 0,
    Z => 3,
  },

};

my $sum;
while (<>) {
    chomp;
    my ($opp,$us) = split(' ', $_);
    say qq[$opp - $us];

    $sum += $pp->{$us} + $gp->{$opp}->{$us};

}

say $sum;



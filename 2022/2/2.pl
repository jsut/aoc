#!/usr/bin/env perl
use 5.18.4;
use strict;

my $pp = {
  X => 1,
  Y => 2,
  Z => 3,
};
my $op = {
  X => 0,
  Y => 3,
  Z => 6,
};
my $gp = {
  A => {
    X => 'Z',
    Y => 'X',
    Z => 'Y',
  },
  B => {
    X => 'X',
    Y => 'Y',
    Z => 'Z',
  },
  C => {
    X => 'Y',
    Y => 'Z',
    Z => 'X',
  },
};


my $sum;
while (<>) {
    chomp;
    my ($opp,$us) = split(' ', $_);
    say qq[$opp - $us];

    $sum += $pp->{$gp->{$opp}->{$us}} + $op->{$us};

}

say $sum;



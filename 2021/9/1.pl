#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my $map;

sub print_map {
    my $map = shift;
    foreach my $row (@$map) {
        say join '', @$row;
    }
}

while (<>) {
    chomp;
    my @row = split '';
    push @$map, \@row;
}

sub get_height {
    my ($map,$r,$c) = @_;
    return defined($map->[$r]->[$c]) ? $map->[$r]->[$c] : 99;
}

sub is_local_min {
    my ($map,$r,$c) = @_;
    my $height = get_height($map,$r,$c);
    for my $x (-1,1) {
        if (get_height($map,$r+$x,$c) <= $height) {
            return 0;
        }
        if (get_height($map,$r,$c+$x) <= $height) {
            return 0;
        }
    }
    return $height + 1;
}

my $risk_sum;

foreach my $r (0 .. @$map - 1) {
    foreach my $c (0 .. @{$map->[$r]} - 1) {
        if (my $risk = is_local_min($map,$r,$c)) {
            say "$r,$c : $risk";
            $risk_sum += $risk;
        }
    }
}
say $risk_sum;


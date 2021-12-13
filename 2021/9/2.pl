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
    if ($r < 0 || $c < 0) {
        return 9;
    }
    return defined($map->[$r]->[$c]) ? $map->[$r]->[$c] : 9;
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

sub get_basin_size {
    my ($map,$r,$c) = @_;
    my $basin_size = 0;
    my @to_check = ([$r,$c]);
    my $checked = {};

    while (@to_check) {
        my $val = shift @to_check;
        my ($x,$y) = @$val;
        say "checking $x,$y";
        if (!$checked->{"$x,$y"} && get_height($map,$x,$y) < 9) {
            say get_height($map,$x,$y);
            say "$x,$y in basin";
            $basin_size++;
            push @to_check, [$x-1,$y],[$x+1,$y],[$x,$y-1],[$x,$y+1];
        }
        $checked->{"$x,$y"} = 1;
    }
    return $basin_size;
}

my @basins;

foreach my $r (0 .. @$map - 1) {
    foreach my $c (0 .. @{$map->[$r]} - 1) {
        if (my $risk = is_local_min($map,$r,$c)) {
            say "$r,$c : low point";
            push @basins, get_basin_size($map,$r,$c);

        }
    }
}

my @b = sort {$a <=> $b } @basins;

say $b[-3] * $b[-2] * $b[-1];

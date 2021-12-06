#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;
use List::Util qw/min max/;

my $map = [];


sub print_map {
    my $map = shift;
    foreach my $row (@$map) {
        foreach my $val (@$row) {
            print $val ? $val : '.'
        }
        print "\n";
    }
}

sub scan_map {
    my $map = shift;
    my $count;
    foreach my $row (@$map) {
        foreach my $val (@$row) {
            if ($val && $val > 1){
                $count++;
            }
        }
    }
    return $count;
}

while (<>) {
    chomp;

    my @bits = split ' ';
    my @p1 = split ',', $bits[0];
    my @p2 = split ',', $bits[2];

    if ($p1[1] == $p2[1]) {
        if (!$map->[$p1[1]]) {
            $map->[$p1[1]] = [];
        }
        for (my $i = min $p1[0], $p2[0]; $i <= max $p1[0], $p2[0]; $i++) {
            $map->[$p1[1]]->[$i]++
        }
    }
    elsif ($p1[0] == $p2[0]) {
        for (my $i = min $p1[1], $p2[1]; $i <= max $p1[1], $p2[1]; $i++) {
            if (!$map->[$i]) {
                $map->[$i] = [];
            }
            $map->[$i]->[$p1[0]]++
        }
    }
    else {

        while ($p1[0] != $p2[0]) {
            $map->[$p1[1]]->[$p1[0]]++;
            if ($p1[0] < $p2[0]) {
                $p1[0]++;
            }
            else {
                $p1[0]--;
            }
            if ($p1[1] < $p2[1]) {
                $p1[1]++;
            }
            else {
                $p1[1]--;
            }
        }
        $map->[$p2[1]]->[$p2[0]]++;
    }
}
print_map($map);
say scan_map($map);


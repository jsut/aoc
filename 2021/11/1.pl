#!/usr/bin/env perl
use 5.18.4;
use strict;

my $map;

while (<>) {
    chomp;
    my @row = split '';
    push @$map, \@row;
}

sub print_map {
    my $map = shift;
    foreach my $row (@$map) {
        say join '', @$row;
    }
    say '------'
}

my $flashes;

sub flash {
    my ($map,$flashed,$x,$y) = @_;
    if ($flashed->{$x}->{$y}) {
        return;
    }
    $flashes++;
    $flashed->{$x}->{$y} = 1;
    foreach my $x1 (-1..1) {
        foreach my $y1 (-1..1) {
            if ($x1 == 0 && $y1 == 0) {
                next;
            }
            if ($x+$x1 >= 0 && $y+$y1 >= 0 && $x+$x1 < @$map && $y+$y1 < @{$map->[$x]}) {
                $map->[$x+$x1]->[$y+$y1] += 1;
                if ($map->[$x+$x1]->[$y+$y1] > 9){
                    flash($map,$flashed,$x+$x1,$y+$y1);
                }
            }
        }
    }
}

sub process_map {
    my $map = shift;
    my @new_map;
    my $flashed = {};

    #increment
    foreach my $row (@$map) {
        my @new_row;
        foreach my $val (@$row) {
            push @new_row, $val + 1;
        }
        push @new_map, \@new_row;
    }
    
    #find flashers
    for (my $x = 0; $x < @$map; $x++) {
        for (my $y = 0; $y < @{$map->[$x]}; $y++) {
            if ($new_map[$x]->[$y] > 9 && !$flashed->{$x}->{$y}) {
                flash(\@new_map,$flashed,$x,$y);
            }
        }
    }
    foreach my $x (keys %$flashed) {
        foreach my $y (keys %{$flashed->{$x}}) {
            $new_map[$x]->[$y] = 0;
        }
    }

    return \@new_map;
}


print_map($map);
for (0..99) {
    $map = process_map($map);
}
print_map($map);
say $flashes;
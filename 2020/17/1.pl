#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

sub print_cube {
    my $cube = shift;

    foreach my $plane (@$cube) {
        foreach my $row (@$plane) {
            say join '', @$row;
        }
        say;
    }
}

sub get_state_at_pos {
    my ($cube,$x,$y,$z) = @_;
    my $max_plane = @$cube - 1;
    my $max = @{$cube->[0]} - 1;
    #say "looking for:  $x,$y,$z ($max)";
    if ($x < 0 || $x > $max_plane) {
        return '.';
    }
    foreach my $i ($y,$z) {
        if ($i < 0 || $i > $max) {
            return '.';
        }
    }
    #say $cube->[$x]->[$y]->[$z] || '.';
    return $cube->[$x]->[$y]->[$z] || '.';
}

sub get_active_neighbours {
    my ($cube,$x,$y,$z) = @_;

    my $count;
    for my $tx ($x-1..$x+1) {
        for my $ty ($y-1..$y+1) {
            for my $tz ($z-1..$z+1) {
                next unless $tx != $x || $ty != $y || $tz != $z;
                if (get_state_at_pos($cube,$tx,$ty,$tz) eq '#'){
                    #say 'living';
                    $count++;
                }
            }
        }
    }
    return $count;
}

sub count_active {
    my ($cube) = @_;

    my $count;
    for my $tx (0..@$cube) {
        for my $ty (0..@{$cube->[0]}) {
            for my $tz (0..@{$cube->[0]}) {
                if (get_state_at_pos($cube,$tx,$ty,$tz) eq '#') {
                    $count++;
                }
            }
        }
    }
    return $count;
}

sub cycle_cube {
    my $cube = shift;
    my $max_plane = @$cube - 1;
    my $max_dim = @{$cube->[0]} - 1;
    my $new_cube = [];

    say "planes: $max_plane - dim: $max_dim";

    for my $plane (-1..($max_plane + 1)) {
        my $new_plane = [];
        for my $row (-1..($max_dim + 1)) {
            my $new_row = [];
            for my $col (-1..($max_dim + 1)) {
                my $active_neighbours = get_active_neighbours($cube,$plane,$row,$col);
                my $current_state = get_state_at_pos($cube,$plane,$row,$col);
                #say "$current_state, $active_neighbours, $plane,$row,$col";
                if ($current_state eq '#' && ($active_neighbours == 2 || $active_neighbours == 3)) {
                    push @$new_row, '#';
                }
                elsif ($current_state eq '.' && $active_neighbours == 3) {
                    push @$new_row, '#';
                }
                else {
                    push @$new_row, '.';
                }
            }
            push @$new_plane, $new_row;
        }
        push @$new_cube, $new_plane;
    }

    return $new_cube;
}


my $cube = [];
my $plane = [];

while (<>) {
    chomp;
    my @row = split //, $_;
    push @$plane,\@row;
}
push @$cube, $plane;

print_cube($cube);
$cube = cycle_cube($cube);
print_cube($cube);
$cube = cycle_cube($cube);
$cube = cycle_cube($cube);
$cube = cycle_cube($cube);
$cube = cycle_cube($cube);
$cube = cycle_cube($cube);
say count_active($cube);




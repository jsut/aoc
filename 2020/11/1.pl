#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

sub count_occupied {
    my ($layout) = @_;
    my $count = 0;
    for my $row (0..@$layout - 1) {
        for my $col (0..@{$layout->[$row]} - 1) {
            if (get_seat_state($layout,$row,$col) eq '#') {
                $count++;
            }
        }
    }
    return $count;
}

sub get_seat_state {
    my ($layout, $row, $col) = @_;
    if ($row < 0 || $col < 0 || $row >= @$layout || $col >= @{$layout->[0]}) {
        return '.';
    }
    return $layout->[$row]->[$col];
}

sub get_adjacent_count {
    my ($layout, $row, $col) = @_;

    my $count = 0;

    for my $r ($row -1 .. $row + 1) {
        for my $c ($col - 1 .. $col + 1) {
            next if $row == $r && $c == $col;
            if (get_seat_state($layout,$r,$c) eq '#') {
                $count++;
            }
        }
    }

    return $count;
}

sub iterate {
    my $layout = shift;
    my $new_layout = [];
    my $changes = 0;
    for my $row (0..@$layout - 1) {
        $new_layout->[$row] ||= [];
        for my $col (0..@{$layout->[$row]} - 1) {
            my $state = $layout->[$row]->[$col];

            if ($state eq '.') {
                $new_layout->[$row]->[$col] = '.';
                #say 'floor';
                next;
            }
            my $adjacent = get_adjacent_count($layout, $row, $col);
            #say $adjacent;

            if ($adjacent == 0 && $state eq 'L') {
                $new_layout->[$row]->[$col] = '#';
                $changes++;
                next;
            }
            elsif ($adjacent >= 4 && $state eq '#') {
                $new_layout->[$row]->[$col] = 'L';
                $changes++;
                next;
            }
            else {
                $new_layout->[$row]->[$col] = $state;
            }
        }
    }
    return ($changes, $new_layout);
}

my $layout = [];
while (<>) {
    chomp;
    my @slots = split //, $_;
    push @$layout, \@slots;
}

my ($count, $layout) = iterate($layout);
say $count;
while ($count != 0 ) {
    say $count;
    say 'looping';
    ($count, $layout) = iterate($layout);
}
say count_occupied($layout);


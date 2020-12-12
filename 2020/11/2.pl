#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

sub count_occupied {
    my ($layout, $print) = @_;
    my $count = 0;
    if ($print) {
        print "\n";
    }
    for my $row (0..@$layout - 1) {
        for my $col (0..@{$layout->[$row]} - 1) {
            my $state = get_seat_state($layout,$row,$col);
            if ($state eq '#') {
                $count++;
            }
            if ($print) {
                print $state;
            }
        }
        if ($print) {
            print "\n";
        }
    }
    if ($print) {
        print "\n";
    }
    return $count;
}

sub get_seat_state {
    my ($layout, $row, $col) = @_;
    if ($row < 0 || $col < 0 || $row >= @$layout || $col >= @{$layout->[0]}) {
        return '';
    }
    return $layout->[$row]->[$col];
}

sub get_adjacent_count {
    my ($layout, $row, $col) = @_;

    my $count = 0;

    for my $r (-1 .. 1) {
        for my $c (-1 .. 1 ) {
            next if $r == 0 && $c == 0;


            my $check_row = $row + $r;
            my $check_col = $col + $c;

            my $state = get_seat_state($layout,$check_row,$check_col);
            #say "$row,$col, $check_row,$check_col: $state";
            while ($state && $state eq '.') {
                $check_row = $check_row + $r;
                $check_col = $check_col + $c;
                $state = get_seat_state($layout,$check_row,$check_col);
                #say "$row,$col, $check_row,$check_col: $state";
            }
            if ($state eq '#') {
                $count++;
                next;
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
            #say "$row,$col: $adjacent";

            if ($adjacent == 0 && $state eq 'L') {
                $new_layout->[$row]->[$col] = '#';
                $changes++;
                next;
            }
            elsif ($adjacent >= 5 && $state eq '#') {
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
while ($count != 0 ) {
    say "changes: $count";
    say 'looping';
    ($count, $layout) = iterate($layout);
}
say count_occupied($layout, 1);


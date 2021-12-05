#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my $called_at;
my @input;
my $boards = [];
my $board_index = 0;

while (<>) {
    chomp;

    if (!$called_at && $_) {
        @input = split ',';
        my $index = 0;
        foreach my $val (@input) {
            $called_at->{$val} = $index++;
        }
        next;
    }

    if (!$_ && @$boards) {
        $board_index++;
        next;
    }

    if (!$boards->[$board_index]) {
        $boards->[$board_index] = []
    }
    if ($_) {
    my @input = split ' ';
    push @{$boards->[$board_index]}, \@input;}
}


sub find_first_bingo {
    my ($called_at, $board) = @_;
    my $lowest_bingo;

    foreach my $row (@$board) {
        my $this_row_bingo;
        foreach my $num (@$row) {
            if ($called_at->{$num} > $this_row_bingo) {
                $this_row_bingo = $called_at->{$num};
            }
        }
        if (!$lowest_bingo || $this_row_bingo < $lowest_bingo ){
            $lowest_bingo = $this_row_bingo;
        }
    }

    foreach (my $i = 0; $i < @$board; $i++){
        my $this_row_bingo;
        foreach my $num (map {$_->[$i]} @$board) {
            if ($called_at->{$num} > $this_row_bingo) {
                $this_row_bingo = $called_at->{$num};
            }
        }
        if (!$lowest_bingo || $this_row_bingo < $lowest_bingo ){
            $lowest_bingo = $this_row_bingo;
        }
    }
    return $lowest_bingo;
}


my $lowest_board;
my $last_called_at;
foreach my $board (@$boards) {
    my $this_lowest = find_first_bingo($called_at, $board);
    say 'this lowest: ', $this_lowest;
    if (!$lowest_board || $this_lowest > $last_called_at){
        $lowest_board = $board;
        $last_called_at = $this_lowest;
        say '-- new lowest: ', $this_lowest;
    }
}

my $sum;
foreach my $row (@$lowest_board) {
    foreach my $num (@$row) {
        if ($called_at->{$num} > $last_called_at) { 
            $sum += $num
        }
    }
}

say $last_called_at;
say $input[$last_called_at];
say Dumper \$lowest_board;
say $sum;
say $sum * $input[$last_called_at] ;
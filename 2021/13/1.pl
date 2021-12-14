#!/usr/bin/env perl
use 5.18.4;
use strict;

my $page = [];
my $mode;

sub fold_y {
    my ($page, $value) = @_;
    my $new_page;
    my $offset = 1;
    my $position = 0;
    my $page_end = @$page;
    while (1) {
        if ($value + $offset > $page_end && $value - $offset < 0) {
            last; 
        }
        $new_page->[$value - $offset]->[$position]
            = ($page->[$value + $offset]->[$position]
             + $page->[$value - $offset]->[$position]) > 0;
        $position++;
        if ($position > @{$page->[$value + $offset]} -1
            && $position > @{$page->[$value - $offset]} -1 ) {
            $position = 0;
            $offset++;
        }
    }
    return $new_page;
}

sub fold_x {
    my ($page, $value) = @_;
    my $new_page;
    my $offset = 1;
    my $position = 0;
    my $page_width = 0;
    my $page_length = @$page;
    foreach my $row (@$page) {
        if (@$row > $page_width) {
            $page_width = @$row;
        }
    }
    #say 'pw: ', $page_width;
    #say 'pl: ', $page_length;
    while (1) {
        #say "o: $offset p: $position";
        if ($value + $offset > $page_width && $value - $offset < 0) {
            last; 
        }
        $new_page->[$position]->[$value - $offset]
            = ($page->[$position]->[$value + $offset]
             + $page->[$position]->[$value - $offset]) > 0;

        $position++;
        if ($position > $page_length) {
            $position = 0;
            $offset++;
        }
    }
    return $new_page;
}

sub count_dots {
    my $page = shift;
    my $count;
    foreach my $row (@$page) {
        foreach my $val (@$row) {
            if ($val) {
                $count++;
            }
        }
    }
    return $count;
}

sub print_page {
    my $page = shift;
    say '----';
    foreach my $row (@$page) {
        foreach my $val (@$row) {
            print $val ? '#' : '.'
        }
        print "\n";
    }
    say '----';
}

while (<>) {
    chomp;

    if (!$_) {
        $mode++;
        print_page($page);
        next;
    }

    if (!$mode) {
        my ($x,$y) = split ',';
        $page->[$y]->[$x] = '1';
    }
    else {
        my @bits = split ' ';
        my ($axis,$value) = split '=', $bits[2];
        if ($axis eq 'y') {
            $page = fold_y($page,$value);
        }
        if ($axis eq 'x') {
            $page = fold_x($page,$value);
        }
        #print_page($page);
        say count_dots($page);
        say '####';
    }
}
print_page($page);






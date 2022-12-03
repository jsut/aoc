#!/usr/bin/env perl
use 5.18.4;
use strict;
use List::MoreUtils qw/first_index uniq/;

my $sum;
my @values = ('a'..'z','A'..'Z');
my @sacks;

while (<>) {
    chomp;
    my @items =  split '';
    push @sacks, \@items;
}

while (@sacks) {
    my $a = shift @sacks;
    my $b = shift @sacks;
    my $c = shift @sacks;

    say 'sup';

    say join ' ', @$a;
    say join ' ', @$b;
    say join ' ', @$c;

    for (my $i = 0; $i < @values; $i++) {
        my $check = $values[$i];
        say qq[checking $check];
        my @am = grep {$_ eq $check} @$a;
        my @bm = grep {$_ eq $check} @$b;
        my @cm = grep {$_ eq $check} @$c;
        if (@am && @bm && @cm) {
            say qq[found $check];
            $sum += $i + 1;
            last;
        }
    }
}
say $sum;




#!/usr/bin/env perl
use 5.18.4;
use strict;

my @state;

while (<>) {
    chomp;
    @state = split ',';
}

sub day {
    my @state = @_;
    my @new_state;
    my $num_created = 0;
    for (my $i = 0; $i < @state; $i++) {
        if (!$state[$i]) {
            $new_state[$i] = 6;
            $num_created++;
        } 
        else {
            $new_state[$i] = $state[$i] -1;
        } 
    }
    while ($num_created-- > 0) {
        push @new_state, 8;
    }
    return @new_state;
}

say join ',', @state;
foreach my $day (0..79) {
    @state = day(@state);
}

say scalar @state;




#!/usr/bin/env perl
use 5.18.4;
use strict;

my $facing = '1';
my $wx = -1;
my $wy = 10;

my $x = 0;
my $y = 0;
my @dirs = qw/N E S W/;

sub dist {
    my ($x,$y) = @_;
    return abs $x + abs $y;
}

while (<>) {
    chomp;

    my $action = substr($_,0,1,);
    my $value = substr($_,1);

    say "$action, $value";

    if ($action eq 'F') {
       $x += $value * $wx;
       $y += $value * $wy;
    }
    elsif ($action eq 'N') {
        $wx -= $value;
    }
    elsif ($action eq 'E') {
        $wy += $value;
    }
    elsif ($action eq 'S') {
        $wx += $value;
    }
    elsif ($action eq 'W') {
        $wy -= $value;
    }
    elsif ($action eq 'L') {
        my $turns = ($value / 90) % 4;
        if ($turns == 1) {
            ($wx,$wy) = (0-$wy,$wx);
        }
        elsif ($turns == 2) {
            ($wx,$wy) = (0-$wx, 0-$wy);
        }
        elsif ($turns == 3) {
            ($wx,$wy) = ($wy, 0-$wx);
        }
    }
    #90 = (b, -a); 180 = (-a, -b); 270 = (-b, a); 360 = (a, b).
    elsif ($action eq 'R') {
        my $turns = ($value / 90) % 4;
        if ($turns == 1) {
            ($wx,$wy) = ($wy, 0-$wx);
        }
        elsif ($turns == 2) {
            ($wx,$wy) = (0-$wx, 0-$wy);
        }
        elsif ($turns == 3) {
            ($wx,$wy) = (0-$wy, $wx);
        }
    }
    say "S$x, E$y - S$wx, E$wy";
}
say 'sup';
say abs $x + abs $y;




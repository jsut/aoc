#!/usr/bin/env perl
use 5.18.4;
use strict;

my $facing = '1';
my $x = 0;
my $y = 0;

my @dirs = qw/N E S W/;

while (<>) {
    chomp;

    my $action = substr($_,0,1,);
    my $value = substr($_,1);

    say "$action, $value";

    if ($action eq 'F') {
       $action = $dirs[$facing];
    }

    if ($action eq 'N') {
        $x -= $value;
    }
    elsif ($action eq 'E') {
        $y += $value;
    }
    elsif ($action eq 'S') {
        $x += $value;
    }
    elsif ($action eq 'W') {
        $y -= $value;
    }
    elsif ($action eq 'L') {
        my $turns = $value / 90;
        $facing = ($facing - $turns) % 4;
    }
    elsif ($action eq 'R') {
        my $turns = $value / 90;
        $facing = ($facing + $turns) % 4;
    }
    say "facing: $facing, $x, $y"

}

say abs $x + abs $y;




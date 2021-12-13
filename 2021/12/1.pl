#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my $map = {};

while (<>) {
    chomp;
    my ($o,$d) = split '-';
    $map->{$o}->{$d} = 1;
    $map->{$d}->{$o} = 1;
}

sub is_big_cave {
    my $cave = shift;
    return uc($cave) eq $cave;
}

sub find_path {
    my ($map, $start, $end, $visited) = @_;
#    say "$start, $end";

    my @visited = @$visited;
    my $paths = [];
    if ($start eq $end) {
        return [[]];
    }
    foreach my $target (keys (%{$map->{$start}})) {
        if (!is_big_cave($start)) {
            push @visited, $start;
        }
        if (!grep {$_ eq $target} @visited) {
            my $out = find_path($map, $target, $end, \@visited);
            foreach my $path (@$out) {
                push @$paths, [$target, @$path];
            }
        }
    }
    return $paths; 
}

my $paths = find_path($map, 'start', 'end', []);

say scalar @$paths; 

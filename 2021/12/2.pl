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

sub has_dupe {
    my $path = shift;
    my $caves = {};
    foreach my $cave (@$path) {
        if (++$caves->{$cave} > 1 && !is_big_cave($cave)) {
            return $cave;
        }
    }
    return 0;
}

sub find_path {
    my ($map, $start, $end, $visited) = @_;
    #say "go $start, $end";
    #say "v: ", join ',', @$visited;

    my $paths = [];

    if ($start eq $end) {
        return [[]];
    }
    my @visited = @$visited;
    push @visited, $start;
    my $has_dupe = has_dupe(\@visited);

    foreach my $target (keys (%{$map->{$start}})) {
        if ($target eq 'start') {
            next;
        }
        my @this_visited = grep {$_ eq $target } @visited;

        if (!$has_dupe) {
            my $out = find_path($map, $target, $end, \@visited);
            foreach my $path (@$out) {
                push @$paths, [$target, @$path];
            }
        }
        elsif ($has_dupe && @this_visited < 1 && !is_big_cave($target)) {
            my $out = find_path($map, $target, $end, \@visited);
            foreach my $path (@$out) {
                push @$paths, [$target, @$path];
            }
        }
        elsif ($has_dupe && is_big_cave($target)) {
            my $out = find_path($map, $target, $end, \@visited);
            foreach my $path (@$out) {
                push @$paths, [$target, @$path];
            }
        }
    }
    return $paths; 
}

my $paths = find_path($map, 'start', 'end', []);

say '------';
foreach my $path (@$paths) {
    say join ',', @$path;
}
say scalar @$paths; 

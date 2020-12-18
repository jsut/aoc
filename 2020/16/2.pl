#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;
use Array::Utils qw(:all);

my $input_state;
my @ticket;
my @nearby;

my %options;

while (<>) {
    chomp;

    if ($_ eq '') {
        $input_state++;
        next;
    }

    if (!$input_state) {
        my ($class, $range1s, $range1e,$range2s, $range2e) = $_ =~ m/^([^:]+): (\d+)-(\d+) or (\d+)-(\d+)$/;

        foreach my $i ($range1s..$range1e, $range2s..$range2e) {
            if (!$options{$i}) {
                $options{$i} = []
            }
            push @{$options{$i}}, $class;
        }
    }
    elsif($input_state == 1 && $_ ne 'your ticket:') {
        @ticket = split ',', $_;

    }
    elsif($input_state == 2 && $_ ne 'nearby tickets:') {
        my @near = split ',', $_;
        push @nearby, \@near;
    }
}

say 'all';
say scalar @nearby;
my @valid;

BORK: for my $i (@nearby) {
    for my $j (@$i) {
        if (!$options{$j}) {
            next BORK;
        }
    }
    push @valid, $i;
}

say 'valid';
say scalar @valid;

my @valid_meanings = ();

for my $i (@valid) {
    my $c = 0;
    for my $j (@$i) {
        if ($valid_meanings[$c]) {
            say 'defined';
            my @isect = intersect(@{$valid_meanings[$c]}, @{$options{$j}});
            say join '-', @isect;
            $valid_meanings[$c] = \@isect;
        }
        else {
            say 'not defined';
            push @{$valid_meanings[$c]}, @{$options{$j}};
        }
        $c++;
    }
}


my %labels;

while (scalar keys(%labels) != scalar @ticket) {
    my $c = 0;
    my $field;
    foreach my $row (@valid_meanings) {
        if (@$row == 1) {
            $field = $labels{$c} = shift @$row;
        }
        $c++;
    }
    foreach my $row (@valid_meanings) {
        my @new = grep { $_ ne $field } @$row;
        $row = \@new;
    }
}

say Dumper \%labels;

my $out = 1;
for my $i (0..@ticket) {
    if ($labels{$i} =~ m/^departure/) {
        $out *= $ticket[$i];
    }
}

say $out;




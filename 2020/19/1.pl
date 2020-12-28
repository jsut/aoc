#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my @vm;

my $im;

my %rules;
my @lines;

while (<>) {
    chomp;

    if ($_ eq '') {
        $im++;
        next;
    }

    if (!$im) {
        my ($key, $value) = split ': ', $_;
        if ($value =~ /"/) {
            $rules{$key} = substr($value, 1, 1);
        }
        elsif ($value =~ /\|/) {
            my @parts = split '\|', $value;
            my $ds = [];
            foreach my $part (@parts) {
                my @bits = split ' ', $part;
                push @$ds, {'all' => \@bits };
            }
            $rules{$key} = $ds;

        }
        else {
            my @parts = split ' ', $value;
            $rules{$key} = {
                'all' => \@parts,
            };
        }
    }
    else {
        push @lines, $_;
    }
}


my $valid_strings = [];

sub decode_rule {
    my ($rule) = @_;

    if ($rule =~ /^(a|b)$/) {
        say 'handling string: ', $rule;
        return $rule;
    }
    elsif ($rule =~ /^\d+$/) {
        say 'handing numeric: ', $rule;
        return decode_rule($rules{$rule});
    }
    elsif (ref($rule) eq 'HASH') {
        # a list of rules that must be met in order
        say 'handling hash';
        my @rulez;
        foreach my $rule (@{$rule->{'all'}}) {
            push @rulez, decode_rule($rule)
        }
        return \@rulez;
    }
    elsif (ref($rule) eq 'ARRAY') {
        # two choices of rules to follow in order
        say 'handling array';
        my @rulez;
        my $left = $rule->[0];
        my $right = $rule->[1];
        push @rulez, {'or' => [
            decode_rule($left),
            decode_rule($right),
        ]};
        return \@rulez;
    }
    else {
        say "ref: ", ref($rule);
        next;
    }
}


sub build_regex {
    my $map = shift;
    my $regex = '';
    if (!ref($map)) {
        $regex .= $map;
    }
    elsif (ref($map) eq 'ARRAY') {
        say 'array';
        foreach my $entry (@$map) {
           $regex .= build_regex($entry);
        }
    }
    elsif (ref($map) eq 'HASH') {
        say 'hash';
        $regex .= '('. build_regex($map->{'or'}->[0]) . '|' . build_regex($map->{'or'}->[1]) . ')';
    }
    else {
        say 'uh' . ref($map);
    }
    return $regex;
}

say Dumper \%rules;

my $map = decode_rule($rules{0});
say Dumper $map;
my $regex = build_regex($map);

say $regex;
my $count;
foreach my $line (@lines) {
    say $line;
    if ($line =~ m/^${regex}$/) {
        $count++;
    }
}

say 'found: ', $count;

#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my $memory = {};

sub apply_mask {
    my ($mask, $value) = @_;

    my @write = ();

    my @mask = split //, $mask;
    my @value = split //, sprintf"%036b", $value;
    my @write;

    for my $i (0..35) {
        if ($mask[$i] eq '0') {
            push @write, $value[$i];
        }
        elsif($mask[$i] eq '1') {
            push @write, 1;
        }
        else {
            push @write, 'X'
        }
    }

    return join('',@write);
}

sub mask_to_ints {
    my $mask = shift;
    my @mask  = split //, $mask;

    my $addrs = [[]];

    foreach my $bit (@mask) {
        if ($bit ne 'X') {
            foreach my $i (0 .. @$addrs - 1) {
                push @{$addrs->[$i]}, $bit;
                #say join '-', @{$addrs->[$i]};
            }
        }
        else {
            foreach my $i (0 .. @$addrs - 1) {
                push @$addrs, [@{$addrs->[$i]},1];
                push @{$addrs->[$i]}, 0;
            }

        }
    }

    my @values;

    foreach my $row (@$addrs) {
        push @values, oct('0b'.join '', @$row);
    }

    return \@values;
}

my $mask;

while (<>) {
    chomp;

    my $str;

    if ($_ =~ /^mask/) {
        $mask = substr($_,7);
        say $mask;
        next;
    }

    #mem[2050] = 27965
    my ($addr, $value) = $_ =~ /^mem\[(\d+)\] = (\d+)/;
    say $_;
    say $addr;
    say $value;

    my $addr_mask = apply_mask($mask, $addr);
    say $addr_mask;

    my $addrs = mask_to_ints($addr_mask);
    say 'got addrs';

    foreach my $a (@$addrs) {
        say 'address: ', $a;
        say 'value: ', $value;
        $memory->{$a} = $value;
    }
}

say 'summing';

my $sum;
foreach my $val (keys %$memory){
    $sum += $memory->{$val};
}
say $sum;



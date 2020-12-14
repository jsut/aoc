#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my $memory = [];

sub apply_mask {
    my ($mask, $value) = @_;

    my @mask = split //, $mask;
    my @value = split //, sprintf"%036b", $value;
    my @write;

    for my $i (0..35) {
        if ($mask[$i] ne 'X') {
            push @write, $mask[$i];
        }
        else{
            push @write, $value[$i];
        }
    }

    say 'WASSP';
    say join('',@mask);
    say join('',@value);
    say join('',@write);

    return oct("0b".join('',@write));

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

    $memory->[$addr] = apply_mask($mask, $value);

}

my $sum;
foreach my $val (@$memory){
    $sum += $val;
}
say $sum;



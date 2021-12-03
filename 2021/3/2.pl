#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my @sums;
my $rows;
my @data;

while (<>) {
    chomp;
    my @bits = split // ;
    push @data, \@bits;
}

sub filter_list {
    my ($list, $position) = @_;
    my @zero;
    my @one;
    foreach my $row (@$list) {
        if ($row->[$position]) {
            push @one, $row;
        }
        else {
            push @zero, $row;
        } 
    }
    return @zero > @one ? \@zero : \@one;
}

sub filter_list2 {
    my ($list, $position) = @_;
    my @zero;
    my @one;
    foreach my $row (@$list) {
        if ($row->[$position]) {
            push @one, $row;
        }
        else {
            push @zero, $row;
        } 
    }
    return @zero <= @one ? \@zero : \@one;
}

my $pos = 0;

my @o2 = @data;
my @co2 = @data;
while (@o2 > 1) {
    my $res = filter_list(\@o2, $pos);
    $pos++;
    @o2 = @$res;
}
say Dumper @o2;
my $o2 = join '', @{$o2[0]};
$pos = 0;

while (@co2 > 1) {
    my $res = filter_list2(\@co2, $pos);
    $pos++;
    @co2 = @$res;
}
say Dumper @co2;
my $co2 = join '', @{$co2[0]};

say $o2;
say $co2;

say oct("0b$o2") * oct("0b$co2");

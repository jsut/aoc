#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;
use bigint;

my $earliest = <>;
my $sched = <>;
chomp $earliest;
chomp $sched;

my @buses = split ',', $sched;
my %bus;

foreach my $i (0 .. @buses - 1) {
    next if $buses[$i] eq 'x';
    $bus{$i} = $buses[$i];
}

my $checkto = 0;
my $i = $bus{$checkto};
my $step = $bus{$checkto};

my @keys = sort { $a <=> $b } keys(%bus);
print Dumper \%bus;

WHILE: while() {
    #say '$i: ', $i;
    #say 'step value: ', $step;
    #say 'check to ', $checkto;
    my $sum = 1;

    foreach my $in (0..$checkto) {
        my $test_offset = $keys[$in];
        my $num = $bus{$test_offset};
        if (($i+$test_offset) % $num != 0) {
            #say "$i + $test_offset mod $num != 0";
            next WHILE;
        }
        $sum *= $num;
        #say "$i + $test_offset mod $num == 0";
    }

    say "$checkto: $i - $sum";
    $step = $sum;
    $checkto++;
    if (@keys <= $checkto) {
        say $i . '!!!';
        last WHILE;
    }

#    else {
#        say "fails $bus{$offset}";
#    }
}
continue {
    $i += $step;
}


say $i;


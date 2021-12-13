#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my $sum;

my $fixed_value = {
    2 => 1,
    3 => 7,
    4 => 4,
    7 => 8,
};

sub sort_str {
    my $str = shift;
    my $bin;
    foreach my $letter('a'..'g') {
        $bin .= index($str, $letter) > -1 ? '1' : '0';
    }
    return eval("0b$bin");
}
 
while (<>) {
    chomp;
    my $decoder = {};
    my $coder = {};
    my ($input_string, $output_string) = split '\|';
    say $input_string, $output_string;

    my @numbers = (split(' ', $output_string), split(' ', $input_string));

    #1,4,7,8
    foreach my $num (@numbers) {
        my $snum = sort_str($num);
        if ($fixed_value->{length($num)}) {
            $decoder->{$snum} = $fixed_value->{length($num)};
            $coder->{$fixed_value->{length($num)}} = $snum;
        }
    }
    
    #0,6,9
    foreach my $num (@numbers) {
        my $snum = sort_str($num);

        if (length($num) == 6 && ($snum & $coder->{1}) ne $coder->{1} ) {
            $decoder->{$snum} = 6;
            $coder->{6} = $snum;
        }
        elsif (length($num) == 6 && ($snum & $coder->{4}) eq $coder->{4} ) {
            $decoder->{$snum} = 9;
            $coder->{9} = $snum;
        }
        elsif (length($num) == 6) {
            $decoder->{$snum} = 0;
            $coder->{0} = $snum;
        }
    }

    #2,3,5
    foreach my $num (@numbers) {
        my $snum = sort_str($num);

        if (length($num) == 5 && ($snum & $coder->{1}) == $coder->{1} ) {
            $decoder->{$snum} = 3;
            $coder->{3} = $snum;
        }
        elsif (length($num) == 5 && ($snum & $coder->{6}) == $snum ) {
            $decoder->{$snum} = 5;
            $coder->{5} = $snum;
        }
        elsif (length($num) == 5) {
            $decoder->{$snum} = 2;
            $coder->{2} = $snum;
        }
    }



    say '------';
    say Dumper $coder;
    say Dumper $decoder;
    say '------';
    
    my $out;
    foreach my $digit (split(' ', $output_string)) {
        my $sd = sort_str($digit);
        $out .= $decoder->{$sd};
    }
    say $out;
    $sum += $out;
}

say $sum;


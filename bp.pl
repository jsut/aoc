use 5.18.4;
use strict;

my $input = "a
b
c
d
e";

my @lines = split /\n/, $input;
my $answer;

foreach my $line (@lines) {

    say $line;
    say 'next';

}

say $answer;




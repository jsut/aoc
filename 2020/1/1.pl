use 5.18.4;
use strict;
use File::Slurp;

my @lines = read_file('input');
my %wanted;

foreach my $num (@lines) {
    chomp $num;
    my $pair = 2020 - $num;

    if ($wanted{$pair}) {
        say $num * $pair
    }
    $wanted{$num} = $pair;

}




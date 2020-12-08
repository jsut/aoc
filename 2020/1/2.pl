use 5.18.4;
use strict;
use File::Slurp;

my @lines = read_file('input');
my %found;

foreach my $current (@lines) {
    chomp $current;

    $found{$current} = 1;

    foreach my $previous (keys %found) {
        my $needed = 2020 - $current - $previous;
        if ($found{$needed}) {
            say $current * $previous * $needed;
        }

    }

}




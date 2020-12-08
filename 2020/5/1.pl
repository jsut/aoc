use 5.18.4;
use strict;
use File::Slurp;

my @lines = read_file('input');
my %wanted;

sub bin_to_dec  {
    return oct("0b" . shift);
}

my $highest;

foreach my $line (@lines) {
    chomp $line;

    my $row = substr($line,0,7);
    $row =~ s/F/0/g;
    $row =~ s/B/1/g;
    $row = bin_to_dec($row);

    my $col = substr($line,7,3);
    $col =~ s/L/0/g;
    $col =~ s/R/1/g;
    $col = bin_to_dec($col);

    my $seat = ($row * 8) + $col;

    if ($seat > $highest) {
        $highest = $seat;
    }

}

say $highest;

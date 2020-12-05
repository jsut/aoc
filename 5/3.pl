use 5.18.4;
use strict;
use File::Slurp;

my @lines = read_file('input');

my @seats;

foreach my $line (@lines) {
    chomp $line;
    $line =~ tr/FBLR/0101/;
    my $seat = oct("0b" . $line);
    push @seats, $seat
}

my @sorted = sort { $a <=> $b } @seats;

say 'highest: ' . $seats[-1];

my $start = @sorted[0];
foreach my $seat (@sorted) {
    if ($start != $seat) {
        say "missing ". $start;
        last;
    }
    $start++;
}
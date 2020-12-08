use 5.18.4;
use strict;
use File::Slurp;

my @lines = read_file('input');
my $pos = 0;

my $trees = 0;

foreach my $line (@lines) {
    chomp $line;

    my $line_length = length $line;

    say $line;
    say $pos;
    say substr($line, $pos, 1);

    if (substr($line, $pos, 1) eq '#') {
        say 'counting';
        $trees++
    }

    $pos = ($pos + 3) % $line_length;

}

say $trees;




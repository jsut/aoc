use 5.18.4;
use strict;
use File::Slurp;

my @lines = read_file('input');

sub run_sim {
    my ($over, $down) = @_;

    my $pos = 0;
    my $trees = 0;
    my $row = 0;


    foreach my $line (@lines) {
        chomp $line;

        say $row;

        if ($down > 1 && $row % $down == 1) {
            $row++;
            say 'skipping row';
            next;
        }
        $row++;

        my $line_length = length $line;

        say $line;
        say $pos;
        say substr($line, $pos, 1);

        if (substr($line, $pos, 1) eq '#') {
            say 'counting';
            $trees++
        }

        $pos = ($pos + $over) % $line_length;

    }

    return $trees;

}

say run_sim(1,1) *
run_sim(3,1) *
run_sim(5,1) *
run_sim(7,1) *
run_sim(1,2);



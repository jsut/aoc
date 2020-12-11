use 5.18.4;
use strict;
use File::Slurp;

my @lines = read_file('input');
@lines = sort {$a <=> $b} @lines;

my %diff;

foreach my $i (0 .. scalar @lines -1) {
    chomp $lines[$i];
    my $num = $lines[$i];
    if ($i > 0) {
        $diff{$num - $lines[$i-1]}++;
    }
    else{
        $diff{$num}++;
    }

}
$diff{3}++;

say "done";
say $diff{1} * $diff{3};




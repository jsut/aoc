use 5.18.4;
use strict;
use File::Slurp;

my @lines = read_file('input');
@lines = sort {$a <=> $b} @lines;
@lines = map { chomp $_; $_ } sort {$a <=> $b} @lines;
push @lines, $lines[-1] + 3;

my %routes = (0 => 1);

foreach my $i (@lines) {
    $routes{$i} = $routes{$i-1} + $routes{$i-2} + $routes{$i-3};
    say "$i: $routes{$i}"
}





use 5.18.4;
use strict;
use File::Slurp;

my @lines = read_file('input');
my $pass = 0;

foreach my $input (@lines) {

  my ($count, $char, $password) = split ' ', $input;

  my ($first,$second) = split '-', $count;

  chop($char);

  my $f_match = substr($password, $first - 1, 1) eq $char;
  my $s_match = substr($password, $second - 1 , 1) eq $char;
  if ($f_match xor $s_match) {
    say substr($password, $first - 1, 1);
    say "$f_match $s_match - $input";
    $pass++;
  }
}

say $pass;



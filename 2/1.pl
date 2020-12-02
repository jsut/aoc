use 5.18.4;
use strict;
use File::Slurp;

my @lines = read_file('input');
my $pass = 0;

foreach my $input (@lines) {

  my ($count, $char, $password) = split ' ', $input;

  my ($min,$max) = split '-', $count;

  chop($char);


  my $number = () = $password =~ /$char/g;

  if ($number <= $max && $number >= $min) 
  {
    say "$number: $count $char $password";
    $pass++;
  }


}

say $pass;



#!/usr/bin/env perl
use 5.40.0;
use strict;
use Storable qw(dclone);

my $safe;

while (<>) {
  chomp;
  my @line = split /\s/;

  my @orig_line = @{ dclone(\@line) };

  my $unsafe = test(@line);

  if ($unsafe){
    foreach my $drop (0 .. @orig_line){
      my @line = @{ dclone(\@orig_line) };
      say qq[drop $drop];
      splice( @line, $drop, 1);
      if (!test(@line)) {
        $unsafe = 0;
        last;
      }
    }
  }

  say $unsafe ? 'unsafe' : 'safe';
  if (!$unsafe){ $safe++}

}

say $safe;

sub test {
  my @line = @_;
  my $last = 0;
  my $dir;
  my $unsafe = false;

  say join '---', @line;

  foreach my $val (@line){
     say $val;
     if ($last == 0){
       $last = $val;
       next;
     }
     if ($last == $val){
       $unsafe = 1;
       last;
     }
     if (!$dir){
       $dir = $last > $val ? 'down' : 'up'
     }
     elsif (($dir eq 'down' && $last < $val)|| ($dir eq 'up' and $last > $val)){
       $unsafe = 1;
       last;
     }
     my $diff = abs($last - $val);
     if ($diff > 0 && $diff < 4) {
       $last = $val;
       next;
     }
     else{
       $unsafe =1;
       last;
     }
  }

  return $unsafe;

}

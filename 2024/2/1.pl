#!/usr/bin/env perl
use 5.40.0;
use strict;


my $safe;

while (<>) {
  chomp;
  my @line = split /\s/;
  say join '---', @line;

  my $last = 0;
  my $dir;
  my $unsafe = false;

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

  say $unsafe ? 'unsafe' : 'safe';
  if (!$unsafe){ $safe++}

}

say $safe;




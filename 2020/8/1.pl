#!/usr/bin/env perl
use 5.18.4;
use strict;

my $acc;
my @lines;
while (<>) {
    chomp;
    push @lines, $_;
}

my %seen;
my $line;
$line = 0;

while (!$seen{$line}) {
    my $cur_cmd = $lines[$line];
    $seen{$line}++;

    my ($cmd,$val) = split ' ', $cur_cmd;
    my $operation = substr($val, 0,1);
    my $amt = substr($val, 1);

    if ($cmd eq 'nop') {
        $line++;
        next;
    }

    if ($cmd eq 'jmp') {
        if ($operation eq '-') {
            $line -= $amt;
        }
        elsif ($operation eq '+') {
            $line += $amt;
        }
        next;
    }

    if ($cmd eq 'acc') {

        if ($operation eq '-') {
            $acc -= $amt;
        }
        elsif ($operation eq '+') {
            $acc += $amt;
        }
        $line++;
        next;
    }
}

say "line $line";
say "acc $acc";




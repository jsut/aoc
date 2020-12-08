#!/usr/bin/env perl
use 5.18.4;
use strict;

my @lines;
while (<>) {
    chomp;
    push @lines, $_;
}

my %changed;

sub run_it {
    my $acc;
    my $lines = shift;

    my %seen;
    my $line;
    $line = 0;

    while (!$seen{$line}) {
        my $cur_cmd = $lines->[$line];
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

    return ($line, $acc);

}

my $num_lines = @lines;

foreach my $line (0..$num_lines) {
    my $cmd = $lines[$line];

    say "checking line $line: $cmd";

    my ($ret_line,$acc);

    if (substr($cmd,0,3) eq 'jmp') {
        say 'swapping jmp';
        my @my_lines = @lines;
        $my_lines[$line] =~ s/jmp/nop/;
        ($ret_line, $acc) = run_it(\@my_lines);
    }
    if (substr($cmd,0,3) eq 'nop') {
        say 'swapping nop';
        my @my_lines = @lines;
        $my_lines[$line] =~ s/nop/jmp/;
        ($ret_line, $acc) = run_it(\@my_lines);
    }

    if ($ret_line == $num_lines) {
        say " ---- $acc";
        last;
    }


}

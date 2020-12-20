#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

sub process_equation {
    my $equation = shift;

    if ($equation && @$equation) {
        say "solving: ", join '', @$equation;
    }
    my $solution;
    my $operation;

    while ($equation && @$equation) {
        my $element = shift @$equation;

        if ($element  =~ /^\d+$/ && !$solution) {
            #say "first element is $element";
            $solution = $element;
            next;
        }
        if ($element  =~ /^\d+$/ && $operation) {
            #say "calculation $solution $operation $element";
            eval "\$solution = $solution $operation $element";
            $operation = '';
        }
        elsif ($element eq ')') {
            #say "end paren: $solution ! ", join '', @$equation;
            return ($solution, $equation);
        }
        elsif ($element eq '(') {
            #say "start paren: $solution ( ! ", join '', @$equation;
            my $paren_solution;
            ($paren_solution, $equation) = process_equation($equation);
            #say "calculation $solution $operation $paren_solution";
            eval "\$solution = $solution $operation $paren_solution";
            $operation = '';
        }
        elsif ($element !~ /^\d+$/) {
            $operation = $element;
        }
        else {
            say 'wtf';
            say $element , join '', @$equation;
            die;
        }
    }
    say "solved: $solution";
    return $solution;
}

my @lines;
while (<>) {
    chomp;
    my @array = grep { $_ ne ' ' } split //, $_;
    push @lines, \@array;
}


#my @test = grep { $_ ne ' '} split //, "1 + 2 * 3 + 4 * 5 + 6";
#my @test = grep { $_ ne ' '} split //, "1 + (2 * 3) + (4 * (5 + 6))";
#my @test = grep { $_ ne ' '} split //, "2 * 3 + (4 * 5)";
#my @test = grep { $_ ne ' '} split //, "5 + (8 * 3 + 9 + 3 * 4 * 3)";
#my @test = grep { $_ ne ' '} split //, "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))";
#my @test = grep { $_ ne ' '} split //, "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2";

my $sum;
foreach my $line (@lines) {
    my $value = process_equation($line);
    $sum += $value;
}

say $sum;

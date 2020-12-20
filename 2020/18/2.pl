#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

sub process_equation {
    my ($equation) = @_;

    if ($equation && @$equation) {
        #say "solving: ", join ' ', @$equation;
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
        elsif ($element  =~ /^\d+$/ && $operation eq '+') {
            #say "+ calculation $solution $operation $element";
            eval "\$solution = $solution $operation $element";
            #say "+ set solution to $solution";
            $operation = '';
            #say "+ equation is $solution ! ", join ' ', @$equation;
        }
        elsif ($element  =~ /^\d+$/ && $operation) {
            my $remainder_solution;
            unshift @$equation, $element;
            #say "start multiplication: $solution $operation ! ", join ' ', @$equation;
            ($remainder_solution, $equation) = process_equation($equation);
            #say "* calculation $solution $operation $remainder_solution";
            eval "\$solution = $solution $operation $remainder_solution";
            #say "* set solution to $solution";
            $operation = '';
            #say "* equation is $solution ! ", join ' ', $equation ? @$equation : [];
            return ($solution, $equation);
        }
        elsif ($element eq ')') {
            say "end paren: $solution ! ", join ' ', @$equation;
            return ($solution, $equation);
        }
        elsif ($element eq '(') {

        #### something ain't right here
            say "start paren: $solution $operation ( ! ", join ' ', @$equation;
            my $paren_solution;
            ($paren_solution, $equation) = process_equation($equation);
            say "back from paren: s:$solution o:$operation ps:$paren_solution ! ", join ' ', $equation ? @$equation : [];
            if ($solution && $operation) {
                unshift @$equation, $paren_solution;
                unshift @$equation, $operation;
                say "( update equation to: $solution ", join ' ', $equation ? @$equation : [];
            }
            else {
                $solution = $paren_solution;
                say "2( update equation to $solution ", join ' ', $equation ? @$equation : [];
            }
        }
        elsif ($element !~ /^\d+$/) {
            #say "set operation to $element";
            $operation = $element;
        }
        else {
            say "wtf: s: $solution e: $element o: $operation";
            say $element , join ' ', @$equation;
            die;
        }
    }
    say "solved: $solution";
    return ($solution);
}

my @lines;
while (<>) {
    chomp;
    my @array = grep { $_ ne ' ' } split //, $_;
    push @lines, \@array;
}


my @tests = (
    [
        [ grep { $_ ne ' '} split //, "1 + 2 * 3 + 4 * 5 + 6" ],
        231
    ],
    [
        [ grep { $_ ne ' '} split //, "1 + (2 * 3) + (4 * (5 + 6))" ],
        51
    ],
    [
        [ grep { $_ ne ' '} split //, "2 * 3 + (4 * 5)" ],
        46
    ],
    [
        [ grep { $_ ne ' '} split //, "5 + (8 * 3 + 9 + 3 * 4 * 3)" ],
        1445
    ],
    [
        [ grep { $_ ne ' '} split //, "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))" ],
        669060
    ],
    [
        [ grep { $_ ne ' '} split //, "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2" ],
        23340
    ],
    [
        [ grep { $_ ne ' '} split //, "2 + (2*1) * 3"] ,
        12
    ],
    [
        [ grep { $_ ne ' '} split //, "2 + (2*(1*1)+(1*1)) * 3"] ,
        18
    ],
    [
        [ grep { $_ ne ' '} split //, "2"] ,
        2
    ],
    [
        [ grep { $_ ne ' '} split //, "2 + 2"] ,
        4
    ],
    [
        [ grep { $_ ne ' '} split //, "3 * 2"] ,
        6
    ],
    [
        [ grep { $_ ne ' '} split //, "(2 * 3)"] ,
        6
    ],
    [
        [ grep { $_ ne ' '} split //, "2 * (2 * 1) + 3"] ,
        10
    ],
    [
        [ grep { $_ ne ' '} split //, "(2 * (2 * 1)) + 3 * 3"] ,
        21
    ],
);


#foreach my $test (@tests) {
#    my ($value) = process_equation($test->[0]);
#    say $value, ' ', $test->[1];
#    die unless $value == $test->[1];
#    say "NEXT\n\n";
#}

my $sum;
foreach my $line (@lines) {

    say 'WASSUP: ', join ' ', @$line;
    my ($value) = process_equation($line);
    say 'result: ', $value;
    $sum += $value;

    say "\n\n\n\n";
}

say 'sum: ', $sum;

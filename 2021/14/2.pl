#!/usr/bin/env perl
use 5.18.4;
use strict;
use Data::Dumper;

my $template;
my $rules;

while (<>) {
    chomp;

    if (!$_) {
        next;
    }
    elsif (!$template) {
        my @char = split '';
        for (my $i = 0; $i < @char -1; $i++) {
            $template->{$char[$i].$char[$i+1]}++;
        }
        next;
    }
    else {
        my @bits = split ' ';
        my @chars = split '', $bits[0];
        $rules->{$bits[0]} = [$chars[0] . $bits[2], $bits[2]. $chars[1]];
    }
}

sub apply {
    my ($rules,$template) = @_;
    my $new_template;
    while (my ($double, $count) = each %$template) {
        my $t = $rules->{$double};
        $new_template->{$t->[0]} += $count;
        $new_template->{$t->[1]} += $count;
    }
    return $new_template;
}

for (0..39) {
    $template = apply($rules, $template);
    say Dumper $template
}

my $letters;
while (my ($double, $count) = each %$template) {
    foreach my $t (split '', $double) {
        $letters->{$t} += $count;
    }
}

while (my ($double, $count) = each %$letters) {
    say $double, ': ', int(($count+1)/2);
}

my @freq = sort {$a <=> $b } values %$letters;

say int(($freq[-1]+1)/2) - int(($freq[0]+1)/2);




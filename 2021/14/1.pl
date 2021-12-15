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
        $template = $_;
        next;
    }
    else {
        my @bits = split ' ';
        $rules->{$bits[0]} = $bits[2];
    }
}

sub apply {
    my ($rules,$template) = @_;
    my $new_template = substr($template,0,1);
    for (my $i = 0; $i < length($template); $i++) {
        my $bit = substr($template, $i, 2);
        $new_template.= $rules->{$bit} . substr($template, $i + 1, 1);
    }
    return $new_template;
}

for (0..9) {
    $template = apply($rules, $template);
}

my $letters;
foreach my $t (split '', $template) {
    $letters->{$t}++
}
my @freq = sort {$a <=> $b } values %$letters;

say $freq[-1] - $freq[0];




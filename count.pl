use strict;
use warnings;
use Data::Dumper;

open(DAT, 'out.txt');
chomp (my @z = <DAT>);
close(DAT);

my %cnt;

for my $i (@z) {
    my ($d, $wd) = split(/\t/, $i);
    $cnt{$wd}++ if $wd gt'';
}

print Dumper \%cnt;

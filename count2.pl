use strict;
use warnings;
use Data::Dumper;

open(DAT, 'out.txt');
chomp (my @z = <DAT>);
close(DAT);

my %cnt;

for my $i (@z) {
    chomp $i;
    my ($d, $wd) = split(/\t/, $i);
    my ($d1, $d2, $y) = split(/\./, $d);
        
    $cnt{$y}++ unless $wd eq 'SO' or $wd eq 'SA';
}

for (sort keys %cnt) {
    printf "%-8s %s\n", $_, $cnt{$_};
}

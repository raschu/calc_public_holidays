use strict;
use warnings;

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
    printf "%-8s %-8s ", $_, $cnt{$_};
    print "*" for 1..$cnt{$_};
    print "\n";
}

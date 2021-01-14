use strict;
use warnings;
use Date::Easter;
use Date::Manip;
use Date::Calc qw(Day_of_Week);

my %dow = (
    '1' => 'MO',
    '2' => 'DI',
    '3' => 'MI',
    '4' => 'DO',
    '5' => 'FR',
    '6' => 'SA',
    '7' => 'SO'
);

my %month = (
    '1' => 'jan',
    '2' => 'feb',
    '3' => 'mar',
    '4' => 'apr',
    '5' => 'may',
    '6' => 'jun',
    '7' => 'jul',
    '8' => 'aug',
    '9' => 'sep',
    '10' => 'oct',
    '11' => 'nov',
    '12' => 'dec'
);

my %ftag = (
    '1' => 'Neujahrstag',
    '2' => 'Heilige Drei Könige',
    '3' => 'Schmudo (Nachmittag frei)',
    '4' => 'Josefstag',
    '5' => 'Karfreitag',
    '6' => 'Ostermontag',
    '7' => 'Auffahrt',
    '8' => 'Pfingstmontag',
    '9' => 'Fronleichnam',
    '10' => 'Nationalfeiertag',
    '11' => 'Mariä Himmelfahrt',
    '12' => 'Allerheiligen',
    '13' => 'St. Martin',
    '14' => 'Mariä Empfängnis',
    '15' => 'Vorweihnachtstag (Nachmittag frei)',
    '16' => 'Weihnachten',
    '17' => 'Stephanstag',
    '18' => 'Silvester (Nachmittag frei)'
);

my @fix = qw (0101 0106 0319 0801 0815 1101 1111 1208 1224 1225 1226 1231);
my @container;

for my $y (2000..2050) {
    
    undef @container;
    
    my ($month, $day) = gregorian_easter($y);
    my $easter = "$day-$month{$month}-$y";
    
    #Schmudo
    formatdate($easter, '- 52 days');
    #Karfreitag
    formatdate($easter, '- 2 days');
    #Ostermontag
    formatdate($easter, '+ 1 days');
    #Auffahrt
    formatdate($easter, '+ 39 days');
    #Pfingstmontag
    formatdate($easter, '+ 50 days');
    #Fronleichnam
    formatdate($easter, '+ 60 days');
    
    push(@container, "$y$_") for @fix;
    
    my $cnt = 0;
    for my $d (sort @container) {
        $cnt++;
        my $year  = substr($d, 0, 4);
        my $month = substr($d, 4, 2);
        my $day   = substr($d, 6, 2);
        my $dow   = Day_of_Week($year,$month,$day);

        print "$day.$month.$year\t$dow{$dow}\t$ftag{$cnt}\n";
    }
}

sub formatdate {
    my $i = shift;
    my $d = shift;
    my $r;
    
    $r = DateCalc(ParseDate($i), ParseDateDelta($d));
    $r =~ s/00:00:00//;
    
    push(@container, $r);
    
    return $r;
}

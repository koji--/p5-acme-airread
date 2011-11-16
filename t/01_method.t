use strict;
use warnings;
use Test::More;
use Acme::AirRead;

subtest 'write and read air' => sub {
    write_air(
        air     => 'cant read air',
        declair => 'cant read near air',
        luft    => 'kann keine Luft lesen',
        kuuki   => 'yomenai',
    );

    my $air = read_air('air');
    ok( !defined $air, 'cant get air' );
    my $declair = read_air('declair');
    ok( !defined $declair, 'cant get declair' );
    my $luft = read_air('Luft');
    ok( !defined $luft, 'kann keine Luft lesen' );
    my $kuuki = read_air('kuuki');
    ok( defined $kuuki, 'get kuuki' );
};

subtest 'i want to read air' => sub {
    empty_air();
    $Acme::AirRead::NO_READ = qr{ky};
    write_air(
        air   => 'cant air',
        kuuki => 'yomenai',
    );

    my $air = read_air('air');
    ok( defined $air, 'i can read air' );
    my $kuuki = read_air('kuuki');
    ok( defined $kuuki, 'i can read kuuki' );
    my $ky = read_air('KY');
    ok( !defined $ky, 'cant read ky' );
};

done_testing;

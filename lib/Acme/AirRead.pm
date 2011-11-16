package Acme::AirRead;

use 5.014;
use warnings;
no strict 'refs';
our $VERSION = '0.01';
our $NO_READ = qr{air|luft};

sub import {
    my ($pkg) = caller(0);
    *{ $pkg . '::read_air' } = \&read_air;
    *{ $pkg . '::write_air' } = \&write_air;
    *{ $pkg . '::empty_air' } = \&empty_air;
}

sub read_air {
    my ($pkg) = caller(0);
    my $key = lc $_[0];
    return if $key =~ $NO_READ;
    return *{ $pkg . '::AirRead::attr' . $_[0] };
}

sub write_air {
    my ($pkg) = caller(0);
    return if scalar @_;
    my %args = @_;
    foreach my $key ( sort keys %args ) {
        my $val = $args{$key};
        *{ $pkg . '::AirRead::attr' . $key } = $val;
    }
}

sub empty_air {
    my ($pkg) = caller(0);
    my $symbol_tbl = $pkg . '::AirRead::attr';
    foreach my $symbol ( keys %$symbol_tbl ) {
        delete $symbol_tbl->{$symbol};
    }
}

1;
__END__

=head1 NAME

Acme::AirRead - accessor for reading air.

=head1 SYNOPSIS

  use Acme::AirRead;

  write_air(any_key => 'any_word');
  my $word = read_air('any_key'); # undef

  write_air(air => 'any_word');
  $word = read_air();       # 'any_word'
  $word = read_air('air');  # 'any_word'

  empty_air();
  $word = read_air('any_key');  # undef
  $word = read_air();           # undef
  $word = read_air('air');      # undef

=head1 DESCRIPTION

Acme::AirRead is accessor for reading air.

detail is reading air.

=head1 AUTHOR

Koji Takiguchi E<lt>kojiel {at} gmail.comE<gt>

=head1 SEE ALSO

Class::Accessor::Lite

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

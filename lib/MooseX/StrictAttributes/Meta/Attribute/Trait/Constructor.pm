package MooseX::StrictAttributes::Meta::Attribute::Trait::Constructor;
use Moose::Role;
use namespace::clean -except => 'meta';

with 'MooseX::StrictConstructor::Role::Object';

package # Hide from PAUSE
    Moose::Meta::Attribute::Custom::Trait::StrictConstructor;

sub register_implementation { 'MooseX::StrictAttributes::Meta::Attribute::Trait::Constructor' }

1;

__END__

=head1 NAME

MooseX::StrictAttributes::Meta::Attribute::Trait::Constructor - An attribute metaclass trait which
composes L<MooseX::StrictConstructor::Role::Object>.

=head1 SYNOPSIS

    package My::Class
    use Moose;
    use MooseX::StrictAttributes ();

    # Ok
    has foo ( isa => 'Bar', traits => [qw/ StrictConstructor /] );

    # Throws exception
    has bar ( unknown => 'Foo', traits => [qw/ StrictConstructor /] );

=head1 DESCRIPTION

Performs a check that all of the keys used in the attribute definition are 
known.

=head1 BUGS AND SOURCE CODE

This software probably contains bugs somewhere, and the way in which some components
are implemented is not optimal.

Patches welcome. 

=head1 AUTHORS

Tomas Doran <bobtfish@bobtfish.net> (t0m on #moose)

=head1 COPYRIGHT AND LICENSE

Copyright 2008 Tomas Doran.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

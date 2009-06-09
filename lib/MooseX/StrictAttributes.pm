package MooseX::StrictAttributes;
use strict;
use warnings;

use Moose ();
use Moose::Exporter;
use Moose::Util::MetaRole;

use MooseX::StrictAttributes::Meta::Attribute::Trait::Isa;
use MooseX::StrictAttributes::Meta::Attribute::Trait::Builder;
#use MooseX::StrictAttributes::Meta::Attribute::Trait::Constructor;

our $VERSION = '0.0001';

Moose::Exporter->setup_import_methods( also => 'Moose' );

sub init_meta {
    shift; # our class name
    my %options = @_;
    my $meta = Moose->init_meta( %options );

    Moose::Util::MetaRole::apply_metaclass_roles(
        for_class                 => $options{for_class},
        attribute_metaclass_roles => [qw/
            MooseX::StrictAttributes::Meta::Attribute::Trait::Isa
            MooseX::StrictAttributes::Meta::Attribute::Trait::Builder
        /],
    );

}

1;

__END__

=head1 NAME

MooseX::StrictAttributes - A collection of Attribute and Class traits to turn on various
'strict' features of attributes.

=head1 SYNOPSIS

    use Moose;
    # Apply all traits to all attributes in this class.
    use MooseX::StrictAttributeBuilders;

    # Or apply to individual attributes
    use MooseX::StrictAttributeBuilders ();
    has foo => ( is => 'ro', traits => [qw/ StrictAttributeBuilders StrictAttributeIsas /] );

=head1 DESCRIPTION

When applied, ensures that any attributes you declare with a builder method 
actually have an existant builder method in their class, and ensures that when you use an
isa type constraint which mentions a class name, that class name corresponds to a loaded class

=head1 SEE ALSO

=over

=item L<MooseX::StrictAttributes::Meta::Attribute::Trait::Isa>

=item L<MooseX::StrictAttributes::Meta::Attribute::Trait::Builder>

=back

=head1 BUGS AND SOURCE CODE

This software probably contains bugs, and there are much more elegant ways of
inheriting default attribute traits than those implemented in this code.

Patches welcome.

=head1 AUTHOR

Tomas Doran <bobtfish@bobtfish.net> (t0m on #moose)

=head1 COPYRIGHT AND LICENSE

Copyright 2008 Tomas Doran.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

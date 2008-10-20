package MooseX:::StrictAttributes;
use strict;
use warnings;

our $VERSION = '0.001';

1;

__END__

=head1 NAME

MooseX::StrictAttributes - A collection of Attribute and Class traits to turn on various
'strict' features of attributes.

=head1 SYNOPSIS

    # Apply to all attributes in this class.
    use Moose -traits => [qw/ StrictAttributeBuilders StrictAttributeIsas /];

    # Or apply to individual attributes
    has foo => ( is => 'ro', traits => [qw/ StrictAttributeBuilders StrictAttributeIsas /] );

=head1 DESCRIPTION

When applied, ensures that any attributes you declare with a builder method 
actually have an existant builder method in their class, and ensures that when you use an
isa type constraint which mentions a class name, that class name corresponds to a loaded class

=head1 AUTHORS

Tomas Doran <bobtfish@bobtfish.net>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 Tomas Doran.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
    
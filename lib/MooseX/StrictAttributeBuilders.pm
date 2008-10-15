package MooseX:::StrictAttributeBuilders;
use strict;
use warnings;

our $VERSION = '0.001';

1;

__END__

=head1 NAME

MooseX::StrictAttributeBuilders  - Attribute or Class trait to ensure that all 
attributes have build methods defined on them at compile time.

=head1 SYNOPSIS

    # Apply to all attributes in this class.
    use Moose -traits => [qw/ StrictAttributeBuildersBuilders /];

    # Or apply to individual attributes
    has foo => ( is => 'ro', traits => [qw/ StrictAttributeBuildersBuilders /] );

=head1 DESCRIPTION

When applied, ensures that any attributes you declare with a builder method 
actually have an existant builder method in their class.

=head1 AUTHORS

Tomas Doran <bobtfish@bobtfish.net>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 Tomas Doran.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
    

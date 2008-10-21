package MooseX::StrictAttributes::AddDefaultAttributeTrait;
use Moose::Role;
use List::MoreUtils qw/any/;
use namespace::clean -except => [qw/ meta /];

{
    my @list_of_traits;
    sub __generate_attribute_trait_appender {
        my ($self, $trait) = @_;
        push(@list_of_traits, $trait);
    }

    around 'add_attribute' => sub {
        my $orig = shift;
        my $class = shift;
        my $attr_name = shift;
        my $params_hr;
        if (ref $_[0] eq 'HASH') {
            $params_hr = shift;
        }
        else {
            $params_hr = { @_ };
        }
        $params_hr->{traits} ||= [];
        foreach my $trait (@list_of_traits) {
            push(@{ $params_hr->{traits} }, $trait)
                unless any { $trait eq $_ } 
                       @{ $params_hr->{traits} };
        }
        $orig->($class, $attr_name, %$params_hr);
    };
}

1;

__END__

=head1 NAME

MooseX::StrictAttributes::AddDetaultAttributeTrait - A class metaclass role which ensures
that all attributes added to a metaclass have certain traits.

=head1 SYNOPSIS

    package My::Class
    use Moose::Role;
    
    with 'MooseX::StrictAttributes::AddDetaultAttributeTrait';
    
    __PACKAGE__->__generate_attribute_trait_appender('MyTraitName');
    
=head1 DESCRIPTION

Uses an around modifier to capture attribute construction, and ensures that the C<traits> option
passed contains all the values specified.

=head1 BUGS AND SOURCE CODE

The implementation of this component can be considered a bug, as it leaves symbols in the metaclass
namespace. This code should really be using L<Moose::Exporter> to export declerative sugar, which
can later be removed.. See the test suite for more information.

Patches welcome. Please ask in #moose for commit bits.

The source code for this project is in the Moose repository at L<http://code2.0beta.co.uk/moose/svn/>

=head1 AUTHORS

Tomas Doran <bobtfish@bobtfish.net> (t0m on #moose)

=head1 COPYRIGHT AND LICENSE

Copyright 2008 Tomas Doran.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

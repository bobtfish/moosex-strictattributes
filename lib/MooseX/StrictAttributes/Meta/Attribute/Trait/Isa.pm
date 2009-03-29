package MooseX::StrictAttributes::Meta::Attribute::Trait::Isa;
use Moose::Role;

after 'attach_to_class' => sub {
    my ($attr, $class) = @_;
    return unless $attr->has_type_constraint;
    my $type_constraint = $attr->type_constraint;
    if ($type_constraint->isa('Moose::Meta::TypeConstraint::Class')) {
        $attr->__test_class_type_constraint($type_constraint); 
    }
    elsif ($type_constraint->isa('Moose::Meta::TypeConstraint::Parameterized') &&
        $type_constraint->has_type_parameter
    ) {
        $attr->__test_class_type_constraint($type_constraint->type_parameter);
    }
};

sub __test_class_type_constraint {
    my ($attr, $type_constraint) = @_;
    my $type_constraint_class = $type_constraint->class;
 
    confess("Can't create a class type constraint for isa on attribute " . $attr->name .
        " because '" . $type_constraint_class . "' is not a class name") 
        unless Class::MOP::is_class_loaded($type_constraint_class);
}

sub _is_valid_class_name {
    my $class = shift;

    return 0 if ref($class);
    return 0 unless defined($class);
    return 0 unless length($class);

    return 1 if $class =~ /^\w+(?:::\w+)*$/;

    return 0;
}

package # Hide from PAUSE
    Moose::Meta::Attribute::Custom::Trait::StrictIsa;

sub register_implementation { 'MooseX::StrictAttributes::Meta::Attribute::Trait::Isa' }

1;

__END__

=head1 NAME

MooseX::StrictAttributes::Meta::Attribute::Trait::Isa - An attribute metaclass trait which
enures that all class types attached to an attribute with isa refer to loaded classes.

=head1 SYNOPSIS

    package My::Class
    use Moose;
    
    # Throws exception as we haven't loaded Other::Class
    has foo ( isa => 'Other::Class', traits => [qw/ StrictIsa /] );

    package Other::Class;
    use Moose;
    
    # This is now fine, as we defined My::Class above
    has bar ( isa => 'My::Class', traits => [qw/ StrictIsa /] );

=head1 DESCRIPTION

Performs a check that the C<isa> type of any attributes with this type, if a class type,
refers to a valid and loaded class. This module will also try to introspect more complex
(e.g. parametrized and union) type constraints, extract any class types from them, and
test they also refer to valid classes.

=head1 BUGS AND SOURCE CODE

This software probably contains bugs somewhere, and the way in which some components
are implemented is not optimal.

Patches welcome.

=head1 AUTHORS

Tomas Doran <bobtfish@bobtfish.net> (t0m on #moose)

=head1 COPYRIGHT AND LICENSE

Copyright 2008 Tomas Doran.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

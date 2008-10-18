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

1;

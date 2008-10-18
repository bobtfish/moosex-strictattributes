package MooseX::StrictAttributes::Meta::Attribute::Trait::Builder;
use Moose::Role;

after 'attach_to_class' => sub {
    my ($attr, $class) = @_;
    return unless $attr->has_builder;
    return if $class->has_method($attr->builder);
    confess(sprintf("No %s method defined for attribute %s", $attr->builder, $attr->name));
};

1;

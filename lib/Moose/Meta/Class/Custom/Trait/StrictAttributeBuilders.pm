package # Hide from PAUSE
    Moose::Meta::Class::Custom::Trait::StrictAttributeBuilders;

sub register_implementation { 'MooseX::StrictAttributes::Meta::Class::Trait::StrictAttributeBuilders' }

1;

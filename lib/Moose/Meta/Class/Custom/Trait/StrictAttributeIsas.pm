package # Hide from PAUSE
    Moose::Meta::Class::Custom::Trait::StrictAttributeIsas;

sub register_implementation { 'MooseX::StrictAttributes::Meta::Class::Trait::StrictAttributeIsas' }

1;


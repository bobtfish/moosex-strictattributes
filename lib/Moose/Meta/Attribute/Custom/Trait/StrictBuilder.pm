package # Hide from PAUSE 
    Moose::Meta::Attribute::Custom::Trait::StrictBuilder;

sub register_implementation { 'MooseX::StrictAttributes::Meta::Attribute::Trait::Builder' }

1;

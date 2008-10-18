package # Hide from PAUSE 
    Moose::Meta::Attribute::Custom::Trait::StrictIsa;

sub register_implementation { 'MooseX::StrictAttributes::Meta::Attribute::Trait::Isa' }

1;
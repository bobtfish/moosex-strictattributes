package # Hide from PAUSE
    Moose::Meta::Class::Custom::Trait::StrictAttributes;
    
sub register_implementation { 'MooseX::StrictAttributes::Meta::Class::Trait::StrictAttributes' }
    
1;

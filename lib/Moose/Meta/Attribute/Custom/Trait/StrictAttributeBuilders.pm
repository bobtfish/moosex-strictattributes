package # Hide from PAUSE 
    Moose::Meta::Attribute::Custom::Trait::StrictAttributeBuilders;

sub register_implementation {
    'MooseX::StrictAttributeBuilders::Attribute::Trait'
}

1;


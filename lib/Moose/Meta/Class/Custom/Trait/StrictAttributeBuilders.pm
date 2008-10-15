package # Hide from PAUSE
    Moose::Meta::Class::Custom::Trait::StrictAttributeBuilders;

sub register_implementation { 'MooseX::StrictAttributeBuilders::Class::Trait' }

1;


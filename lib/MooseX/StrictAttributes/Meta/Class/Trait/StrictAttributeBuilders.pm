package MooseX::StrictAttributes::Meta::Class::Trait::StrictAttributeBuilders;
use Moose::Role;

with 'MooseX::StrictAttributes::AddDefaultAttributeTrait';

__PACKAGE__->__generate_attribute_trait_appender('StrictBuilder');

1;


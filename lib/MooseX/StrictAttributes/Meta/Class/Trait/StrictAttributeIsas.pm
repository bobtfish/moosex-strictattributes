package MooseX::StrictAttributes::Meta::Class::Trait::StrictAttributeIsas;
use Moose::Role;

with 'MooseX::StrictAttributes::AddDefaultAttributeTrait';

__PACKAGE__->__generate_attribute_trait_appender('StrictIsa');

1;

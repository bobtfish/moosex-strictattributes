package MooseX::StrictAttributes::Meta::Class::Trait::StrictAttributeBuilders;
use Moose::Role;

with 'MooseX::StrictAttributes::AddDefaultAttributeTrait';

sub _additional_trait { 'StrictBuilder' }

1;


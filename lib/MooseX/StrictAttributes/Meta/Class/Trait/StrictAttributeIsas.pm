package MooseX::StrictAttributes::Meta::Class::Trait::StrictAttributeIsas;
use Moose::Role;

with 'MooseX::StrictAttributes::AddDefaultAttributeTrait';

sub _additional_trait { 'StrictIsa' }

1;

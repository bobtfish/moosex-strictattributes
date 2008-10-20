use strict;
use Test::More tests => 11;
use Test::Exception;

throws_ok {
    package Some::Class;
    use Moose;
    
    has foo => ( isa => 'Does::Not::Exist', traits => [qw/ StrictIsa /]);
} qr/Can't create a class type constraint for isa on attribute foo because 'Does::Not::Exist' is not a class name/, 
    'Used as a trait on attributes';

throws_ok {
    package Another::Class;
    use Moose -traits => [qw/ StrictAttributeIsas /];
    has foo => ( isa => 'Still::Does::Not::Exist' );
} qr/Can't create a class type constraint for isa on attribute foo because 'Still::Does::Not::Exist' is not a class name/, 
    'Used as a trait on a class';

lives_ok {
    package Some::Other::Class;
    use Moose;
    
    has foo => ( is => 'rw', isa => 'Some::Class', traits => [qw/ StrictIsa /] );
} 'Create class';

{
    my $i;
    lives_ok {
        $i = Some::Other::Class->new;
    } 'Create instance';
    lives_ok {
        $i->foo(Some::Class->new);
    } 'Assign';
    throws_ok {
        $i->foo(Some::Other::Class->new)
    } qr/.*/, 'Throws when assign wrong isa';
}

lives_ok {
    package TestClass::UnionTypes::OK;
    use Moose -traits => [qw/ StrictAttributeIsas /];
    
    has foo => ( isa => 'Some::Class|Some::Other::Class' );
} 'Create class with union type constraint';

lives_ok {
    package TestClass::ParamTypes::OK;
    use Moose -traits => [qw/ StrictAttributeIsas /];
    
    has foo => ( isa => 'Maybe[Some::Class]' );
    has bar => ( isa => 'ArrayRef' );
} 'Create class with param type constraint';

throws_ok {
    package Yet::Another::Class;
    use Moose -traits => [qw/ StrictAttributeIsas /];

    has 'bar' => ( is => 'rw', isa => 'Maybe[Some::Class::Which::Does::Not::Exist]' );
} qr/is not a class name/, 'Create class with param type constraint throws';

throws_ok {
    package TestClass::UnionTypes::Throws;
    use Moose -traits => [qw/ StrictAttributeIsas /];

    has foo => ( isa => 'Some::NonExistant::Class|Some::Other::Class' );
} qr/Could not locate type constraint \(Some::NonExistant::Class\) for the union/, 'Create class with union type constraint throws';

{
    {
        package Running::Out::Of::Names;
        use Moose -traits => [qw/ StrictAttributeIsas /];
    }
    my $i = Running::Out::Of::Names->new;
    TODO: {
        local $TODO = 'Should be using Moose::Exporter sugar that can be namespace::cleand';
        ok(!$i->meta->can('__generate_attribute_trait_appender'), 'Clean namespace in metaclass');
    }
}

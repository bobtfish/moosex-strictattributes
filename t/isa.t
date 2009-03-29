use strict;
use Test::More tests => 8;
use Test::Exception;
use MooseX::StrictAttributes ();

throws_ok {
    package Some::Class;
    use Moose;
    
    has foo => ( isa => 'Does::Not::Exist', traits => [qw/ StrictIsa /]);
} qr/Can't create a class type constraint for isa on attribute foo because 'Does::Not::Exist' is not a class name/, 
    'Used as a trait on attributes';

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
    use Moose;
   
    has foo => ( isa => 'Some::Class|Some::Other::Class', traits => [qw/ StrictIsa /] );
    has bar => ( isa => 'Maybe[Some::Class]', traits => [qw/ StrictIsa /] );
    has baz => ( isa => 'ArrayRef', traits => [qw/ StrictIsa /] );
} 'Create class with union type constraint';

throws_ok {
    package Yet::Another::Class;
    use Moose;

    has 'bar' => ( is => 'rw', traits => [qw/ StrictIsa /], isa => 'Maybe[Some::Class::Which::Does::Not::Exist]' );
} qr/is not a class name/, 'Create class with param type constraint throws';

throws_ok {
    package TestClass::UnionTypes::Throws;
    use Moose;

    has foo => ( isa => 'Some::NonExistant::Class|Some::Other::Class', traits => [qw/ StrictIsa /] );
} qr/Could not locate type constraint \(Some::NonExistant::Class\) for the union/, 'Create class with union type constraint throws';


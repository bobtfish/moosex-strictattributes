use Test::More tests => 3;
use Test::Exception;

{
    package A::Test::Class;
    use Moose;
}

{
    package Some::Class;
    use Test::Exception;
    use Moose;
    use MooseX::StrictAttributes;
    
    has foo => ( is => 'ro' );
    throws_ok {
        has nobuilder => ( isa => 'A::Test::Class', builder => '_build_nobuilder' );
    } qr/No _build_nobuilder method defined for attribute nobuilder/, 
    'No builder throws';
    
    throws_ok {
        has nobuilder => ( isa => 'Another::Test::Class', builder => '_build_nobuilder' );
    } qr/Can't create a class type constraint for isa on attribute nobuilder because 'Another::Test::Class' is not a class name/, 
    'Unknown ISA class throws';

    sub _build_foo { Some::Class->new }
    lives_ok {
        has foo => ( isa => 'Some::Class', builder => '_build_foo', is => 'ro', lazy => 1);
    } 'Attribute with ok builder and ISA works';
}


use Test::More tests => 4;
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
    } qr/MOO/, 'No builder throws';
    throws_ok {
        has nobuilder => ( isa => 'Another::Test::Class', builder => '_build_nobuilder' );
    } qr/MOO/, 'Unknown ISA class throws';
}

{
    {
        package Running::Out::Of::Names;
        use Moose;
        use MooseX::StrictAttributes;
    }
    my $i = Running::Out::Of::Names->new;
    TODO: {
        local $TODO = 'Should be using Moose::Exporter sugar that can be namespace::cleand';
        ok(!$i->meta->can('__generate_attribute_trait_appender'), 'Clean namespace in metaclass');
    }
}

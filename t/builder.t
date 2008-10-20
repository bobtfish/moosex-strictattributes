use strict;
use Test::More tests => 7;
use Test::Exception;

throws_ok {
    package Some::Class;
    use Moose;
    
    has foo => (builder => '_build_foo', traits => [qw/ StrictBuilder /]);
} qr/No _build_foo method defined for attribute foo/, 'Used as a trait on attributes';

throws_ok {
    package Some::Other::Class;
    use Moose -traits => [qw/ StrictAttributeBuilders /];
    has foo => ( is => 'ro', builder => '_build_foo');
} qr/No _build_foo method defined for attribute foo/, 'Used as a trait on a class';

lives_ok {
    package Working::Class;
    use Moose -traits => [qw/ StrictAttributeBuilders /];
    has foo => ( is => 'ro', builder => '_build_foo');
    sub _build_foo { 'bar' }
} 'Ok when build method is present';

my $i = Working::Class->new;
is($i->foo, 'bar', 'Attribute works as expected');

TODO: {
    local $TODO = 'It would be really nice to see the consuming class in the error message';
    
    throws_ok {
        package Some::Class::Redux;
        use Moose;

        has foo => (builder => '_build_foo', traits => [qw/ StrictBuilder /]);
    } qr/No _build_foo method defined for attribute foo in class Some::Class::Redux/, 'Used as a trait on attributes';

    throws_ok {
        package Some::Other::Class::Redux;
        use Moose -traits => [qw/ StrictAttributeBuilders /];
        has foo => ( is => 'ro', builder => '_build_foo');
    } qr/No _build_foo method defined for attribute foo in class Some::Other::Class::Redux/, 'Used as a trait on a class';    
}

{
    {
        package Running::Out::Of::Names;
        use Moose -traits => [qw/ StrictAttributeBuilders /];
    }
    my $i = Running::Out::Of::Names->new;
    TODO: {
        local $TODO = 'Should be using Moose::Exporter sugar that can be namespace::cleand';
        ok(!$i->meta->can('__generate_attribute_trait_appender'), 'Clean namespace in metaclass');
    }
}

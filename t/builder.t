use strict;
use Test::More tests => 5;
use Test::Exception;
use MooseX::StrictAttributes ();

throws_ok {
    package Some::Class;
    use Moose;
    
    has foo => (is => 'ro', builder => '_build_foo', traits => [qw/ StrictBuilder /]);
} qr/No _build_foo method defined for attribute foo/, 'Used as a trait on attributes';

lives_ok {
    package Working::Class;
    use Moose;

    has foo => (is => 'ro', builder => '_build_foo', traits =>  [qw/ StrictBuilder /]);
    sub _build_foo { 'bar' }
} 'StrictBuilder ok on class with build method';

my $i = Working::Class->new;
is($i->foo, 'bar', 'Attribute works as expected');

TODO: {
    local $TODO = 'It would be really nice to see the consuming class in the error message';
    
    throws_ok {
        package Some::Class::Redux;
        use Moose;

        has foo => (is => 'ro', builder => '_build_foo', traits => [qw/ StrictBuilder /]);
    } qr/No _build_foo method defined for attribute foo in class Some::Class::Redux/, 'Used as a trait on attributes';
}

lives_ok {
    package RuntimeMethods;
    use Moose;
    use Sub::Name;

    has foo => (is => 'ro', builder => '_build_foo', traits => [qw/ StrictBuilder /]);
    *_build_foo = subname _build_foo => sub { 'foo' };
} 'Defining methods at runtime after attribute works';


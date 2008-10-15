use strict;
use Test::More tests => 4;
use Test::Exception;

throws_ok {
    package Some::Class;
    use Moose;
    
    has foo => (builder => '_build_foo', traits => [qw/ StrictAttributeBuilders /]);
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


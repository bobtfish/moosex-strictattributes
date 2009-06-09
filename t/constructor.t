#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 2;
use MooseX::StrictAttributes ();

SKIP: {
    skip 'Not implemented yet', 2;

    package Some::Class;
    use Moose;
    use Test::Exception;

    lives_ok {
        has foo => ( isa => 'Bar', traits => [qw/ StrictConstructor /] );
    } 'Ok with known fields';
    throws_ok {
        has foo => ( bar => 'quux', traits => [qw/ StrictConstructor /] );
    } qr/MOO/, 'throws ok when fields unknown';
}


use inc::Module::Install;

name 'MooseX-StrictAttributes';
all_from 'lib/MooseX/StrictAttributes.pm';
license 'perl';

requires 'Moose' => '0.60';
requires 'namespace::clean';
requires 'Scope::Upper';
build_requires 'Test::Exception';

WriteAll;


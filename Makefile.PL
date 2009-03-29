use inc::Module::Install;

name 'MooseX-StrictAttributes';
license 'perl';

requires 'Moose' => '0.60';
requires 'List::MoreUtils';
requires 'namespace::clean';
build_requires 'Test::Exception';

WriteAll;


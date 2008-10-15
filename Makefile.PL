use inc::Module::Install;

name 'MooseX-StrictAttributeBuilders';

requires 'Moose' => '0.60'; # Yes, this isn't out yet..
build_requires 'Test::Exception';

WriteAll;


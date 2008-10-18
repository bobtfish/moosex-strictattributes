use inc::Module::Install;

name 'MooseX-StrictAttributes';

requires 'Moose' => '0.60'; # Yes, this isn't out yet..
requires 'List::MoreUtils';
build_requires 'Test::Exception';

WriteAll;


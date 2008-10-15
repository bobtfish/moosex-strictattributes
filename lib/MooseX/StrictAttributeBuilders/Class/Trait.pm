package MooseX::StrictAttributeBuilders::Class::Trait;
use Moose::Role;
use List::MoreUtils qw/any/;

around 'add_attribute' => sub {
    my $orig = shift;
    my $class = shift;
    my $attr_name = shift;
    my $params_hr;
    if (ref $_[0] eq 'HASH') {
        $params_hr = shift;
    }
    else {
        $params_hr = { @_ };
    }
    $params_hr->{traits} ||= [];
    push(@{ $params_hr->{traits} }, 'StrictAttributeBuilders')
        unless any { 'StrictAttributeBuilders' eq $_ } 
                   @{ $params_hr->{traits} };
    $orig->($class, $attr_name, %$params_hr);
};

1;


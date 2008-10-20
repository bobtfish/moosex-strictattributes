package MooseX::StrictAttributes::AddDefaultAttributeTrait;
use Moose::Role;
use List::MoreUtils qw/any/;


{
    my @list_of_traits;
    sub __generate_attribute_trait_appender {
        my ($self, $trait) = @_;
        push(@list_of_traits, $trait);
    }

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
        foreach my $trait (@list_of_traits) {
            push(@{ $params_hr->{traits} }, $trait)
                unless any { $trait eq $_ } 
                       @{ $params_hr->{traits} };
        }
        $orig->($class, $attr_name, %$params_hr);
    };
}

1;

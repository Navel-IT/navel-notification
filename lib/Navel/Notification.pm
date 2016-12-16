# Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras
# navel-notification is licensed under the Apache License, Version 2.0

#-> BEGIN

#-> initialization

package Navel::Notification 0.1;

use Navel::Base;

use constant {
    I_CLASS => 0,
    I_ID => 1,
    I_ERRORS => 2
};

use Navel::Utils qw/
    croak
    :json
    isint
 /;

#-> class variables

my $json_constructor = json_constructor;

#-> methods

sub deserialize {
    my ($class, $notification) = (shift, $json_constructor->decode(shift));

    croak('notification must be a ARRAY reference') unless ref $notification eq 'ARRAY';

    $class->new(
        class => $notification->[I_CLASS],
        id => $notification->[I_ID],
        errors => $notification->[I_ERRORS]
    );
}

sub new {
    my ($class, %options) = @_;

    $options{errors} //= [];

    croak('errors must be a ARRAY reference') unless ref $options{errors} eq 'ARRAY';

    bless {
        class => $options{class},
        id => $options{id} // croak('id must be defined'),
        errors => $options{errors}
    }, ref $class || $class;
}

sub serialize {
    my $self = shift;

    my @notification;

    $notification[I_CLASS] = $self->{class};
    $notification[I_ID] = $self->{id};
    $notification[I_ERRORS] = $self->{errors};

    $json_constructor->encode(\@notification);
}

# sub AUTOLOAD {}

# sub DESTROY {}

1;

#-> END

__END__

=pod

=encoding utf8

=head1 NAME

Navel::Notification

=head1 COPYRIGHT

Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras

=head1 LICENSE

navel-notification is licensed under the Apache License, Version 2.0

=cut

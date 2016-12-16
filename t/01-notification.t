# Copyright (C) 2015-2016 Yoann Le Garff, Nicolas Boquet and Yann Le Bras
# navel-notification is licensed under the Apache License, Version 2.0

#-> BEGIN

#-> initialization

use strict;
use warnings;

use Test::More tests => 3;
use Test::Exception;

BEGIN {
    use_ok('Navel::Notification');
}

#-> main

my $notification;

lives_ok {
    $notification = Navel::Notification->new(
        class => 't',
        id => 't'
    );
} 'making the notification';

lives_ok {
    $notification->deserialize($notification->serialize);
} 'serialize and deserialize the notification';

#-> END

__END__

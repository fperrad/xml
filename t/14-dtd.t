#! perl
# Copyright (C) 2009, Parrot Foundation.

=head1 Document Type Declaration

=head2 Synopsis

    % perl t/14-dtd.t

=cut

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../../lib", "$FindBin::Bin";

use Parrot::Test tests => 3;
use Test::More;

language_output_is( 'xml', <<'CODE', <<'OUT', 'system' );
<?xml version='1.0'?><!DOCTYPE greeting SYSTEM 'hello.dtd'><greeting>Hello, world!</greeting>
CODE
<?xml version="1.0"?><!DOCTYPE greeting SYSTEM "hello.dtd"><greeting>Hello, world!</greeting>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'internal' );
<?xml version='1.0'?><!DOCTYPE greeting [
    <!ELEMENT greeting (#PCDATA)>
] >
<greeting>Hello, world!</greeting>
CODE
<?xml version="1.0"?><!DOCTYPE greeting [
    <!ELEMENT greeting (#PCDATA)>
]><greeting>Hello, world!</greeting>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'attlist' );
<?xml version='1.0'?><!DOCTYPE greeting [
    <!ELEMENT greeting (#PCDATA)>
    <!ATTLIST greeting id ID #IMPLIED>
] >
<greeting>Hello, world!</greeting>
CODE
<?xml version="1.0"?><!DOCTYPE greeting [
    <!ELEMENT greeting (#PCDATA)>
    <!ATTLIST greeting id ID #IMPLIED>
]><greeting>Hello, world!</greeting>
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

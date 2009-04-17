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

use Parrot::Test tests => 7;
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

language_output_is( 'xml', <<'CODE', <<'OUT', 'attlist' );
<?xml version='1.0'?><!DOCTYPE form [
  <!ATTLIST termdef
            id      ID      #REQUIRED
            name    CDATA   #IMPLIED>
  <!ATTLIST list
            type    (bullets|ordered|glossary) "ordered">
  <!ATTLIST form
            method  CDATA   #FIXED "POST">
]>
<form />
CODE
<?xml version="1.0"?><!DOCTYPE form [
  <!ATTLIST termdef
            id      ID      #REQUIRED
            name    CDATA   #IMPLIED>
  <!ATTLIST list
            type    (bullets|ordered|glossary) "ordered">
  <!ATTLIST form
            method  CDATA   #FIXED "POST">
]><form></form>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'notation' );
<?xml version='1.0'?><!DOCTYPE greeting [
    <!NOTATION note SYSTEM "note.txt">
] >
<greeting>Hello, world!</greeting>
CODE
<?xml version="1.0"?><!DOCTYPE greeting [
    <!NOTATION note SYSTEM "note.txt">
]><greeting>Hello, world!</greeting>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'internal entity' );
<?xml version='1.0'?><!DOCTYPE greeting [
    <!ENTITY Pub-Status "This is a pre-release of the specification">
] >
<greeting>Hello, world!</greeting>
CODE
<?xml version="1.0"?><!DOCTYPE greeting [
    <!ENTITY Pub-Status "This is a pre-release of the specification">
]><greeting>Hello, world!</greeting>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'external entity' );
<?xml version='1.0'?><!DOCTYPE greeting [
    <!ENTITY open-hatch
             SYSTEM "http://www.textuality.com/boilerplate/OpenHatch.xml">
    <!ENTITY open-hatch
             PUBLIC "-//Textuality//TEXT Standard open-hatch boilerplate//EN"
             "http://www.textuality.com/boilerplate/OpenHatch.xml">
    <!ENTITY hatch-pic
             SYSTEM "../grafix/OpenHatch.gif"
             NDATA gif >
] >
<greeting>Hello, world!</greeting>
CODE
<?xml version="1.0"?><!DOCTYPE greeting [
    <!ENTITY open-hatch
             SYSTEM "http://www.textuality.com/boilerplate/OpenHatch.xml">
    <!ENTITY open-hatch
             PUBLIC "-//Textuality//TEXT Standard open-hatch boilerplate//EN"
             "http://www.textuality.com/boilerplate/OpenHatch.xml">
    <!ENTITY hatch-pic
             SYSTEM "../grafix/OpenHatch.gif"
             NDATA gif >
]><greeting>Hello, world!</greeting>
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

#! perl
# Copyright (C) 2009, Parrot Foundation.

=head1 Entities

=head2 Synopsis

    % perl t/30-entity.t

=cut

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../../lib", "$FindBin::Bin";

use Parrot::Test tests => 4;
use Test::More;

language_output_is( 'xml', <<'CODE', <<'OUT', 'prefined entity' );
<elt>2 &gt; 1</elt>
CODE
<elt>2 &gt; 1</elt>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'character reference (dec)' );
<elt> &#65; </elt>
CODE
<elt> A </elt>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'character reference (hex)' );
<elt> &#x41; </elt>
CODE
<elt> A </elt>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'internal entity' );
<?xml version='1.0'?><!DOCTYPE status [
    <!ENTITY Pub-Status "This is a pre-release of the specification">
] >
<status>&Pub-Status;</status>
CODE
<?xml version="1.0"?><!DOCTYPE status [
    <!ENTITY Pub-Status "This is a pre-release of the specification">
]><status>&Pub-Status;</status>
OUT


# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

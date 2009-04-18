#! perl
# Copyright (C) 2009, Parrot Foundation.

=head1 XML Declaration

=head2 Synopsis

    % perl t/13-xmldecl.t

=cut

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../../lib", "$FindBin::Bin";

use Parrot::Test tests => 3;
use Test::More;

language_output_is( 'xml', <<'CODE', <<'OUT', 'version' );
<?xml version='1.0'?><elt>content</elt>
CODE
<?xml version="1.0"?>
<elt>content</elt>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'encoding' );
<?xml version='1.0' encoding='utf-8'?><elt>content</elt>
CODE
<?xml version="1.0" encoding="utf-8"?>
<elt>content</elt>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'standalone' );
<?xml version='1.0' standalone="yes"?><elt>content</elt>
CODE
<?xml version="1.0" standalone="yes"?>
<elt>content</elt>
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

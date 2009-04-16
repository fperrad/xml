#! perl
# Copyright (C) 2009, Parrot Foundation.

=head1 CDATA Sections

=head2 Synopsis

    % perl t/12-cdata.t

=cut

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../../lib", "$FindBin::Bin";

use Parrot::Test tests => 1;
use Test::More;

language_output_is( 'xml', <<'CODE', <<'OUT', 'cdata' );
<elt><![CDATA[content]]></elt>
CODE
<elt><![CDATA[content]]></elt>
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

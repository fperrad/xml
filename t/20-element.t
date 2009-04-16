#! perl
# Copyright (C) 2009, Parrot Foundation.

=head1 Elements

=head2 Synopsis

    % perl t/20-element.t

=cut

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../../lib", "$FindBin::Bin";

use Parrot::Test tests => 2;
use Test::More;

language_output_is( 'xml', <<'CODE', <<'OUT', 'start/end' );
<elt  >content</elt  >
CODE
<elt>content</elt>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'empty' );
<elt  />
CODE
<elt></elt>
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

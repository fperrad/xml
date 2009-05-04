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

use Parrot::Test tests => 5;
use Test::More;

language_output_is( 'xml', <<'CODE', <<'OUT', 'start/end' );
<elt  >content</elt  >
CODE
<elt>content</elt>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'start/end with attributes' );
<elt a="1" b='txt' >content</elt  >
CODE
<elt a="1" b="txt">content</elt>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'empty' );
<elt  />
CODE
<elt></elt>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'empty with attribute' );
<elt a='1' />
CODE
<elt a="1"></elt>
OUT

language_output_like( 'xml', <<'CODE', <<'OUT', 'unbalanced start/end' );
<a><b>content</c></a>
CODE
/^unbalanced end tag: c \(b expected\)\n/
OUT


# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

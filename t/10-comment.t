#! perl
# Copyright (C) 2009, Parrot Foundation.

=head1 Comment

=head2 Synopsis

    % perl t/10-comment.t

=cut

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../../lib", "$FindBin::Bin";

use Parrot::Test tests => 2;
use Test::More;

language_output_is( 'xml', <<'CODE', <<'OUT', 'some comments' );
<!-- first comment --><elt><!-- other comment --></elt><!-- final comment -->
CODE
<!-- first comment --><elt><!-- other comment --></elt><!-- final comment -->
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'some comments' );
<elt>
<!--
    multi-line comment
-->
</elt>
CODE
<elt>
<!--
    multi-line comment
-->
</elt>
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

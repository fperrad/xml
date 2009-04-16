#! perl
# Copyright (C) 2009, Parrot Foundation.

=head1 Processing Instruction

=head2 Synopsis

    % perl t/11-pi.t

=cut

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../../../lib", "$FindBin::Bin";

use Parrot::Test tests => 2;
use Test::More;

language_output_is( 'xml', <<'CODE', <<'OUT', 'some PI' );
<?first_pi?><elt><?other_pi?></elt><?final_pi?>
CODE
<?first_pi?><elt><?other_pi?></elt><?final_pi?>
OUT

language_output_is( 'xml', <<'CODE', <<'OUT', 'with data' );
<?first_pi 42?><elt><?other_pi   with many words  ?></elt><?final_pi   42?>
CODE
<?first_pi 42?><elt><?other_pi with many words  ?></elt><?final_pi 42?>
OUT

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

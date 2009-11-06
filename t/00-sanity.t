#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.

=head1 some XML examples

=head2 Synopsis

    % parrot t/00-sanity.t

=head2 Description

First tests in order to check infrastructure.

=cut

.sub 'main' :main
    load_bytecode 'xml.pir'

    .include 'test_more.pir'

    plan(1)

    test_1()
.end

.sub 'test_1'
     $S1 = <<'XML'
<elt>content</elt>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, $S1, 'ex1')
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


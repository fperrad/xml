#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.

=head1 CDATA Sections

=head2 Synopsis

    % parrot t/12-cdata.t

=cut

.sub 'main' :main
    load_bytecode 'xml.pir'

    .include 'test_more.pir'

    plan(2)

    test_1()
    test_2()
.end

.sub 'test_1'
     $S1 = <<'XML'
<elt><![CDATA[content]]></elt>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, $S1, 'cdata')
.end

.sub 'test_2'
     $S1 = <<'XML'
<elt><![CDATA[ <>&'" ]]></elt>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, $S1, 'cdata')
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


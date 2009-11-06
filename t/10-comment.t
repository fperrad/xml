#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.

=head1 Comment

=head2 Synopsis

    % parrot t/10-comment.t

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
<!-- first comment --><elt><!-- other comment --></elt><!-- final comment -->
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, $S1, 'some comments')
.end

.sub 'test_2'
     $S1 = <<'XML'
<elt>
<!--
    multi-line comment
-->
</elt>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, $S1, 'some comments')
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


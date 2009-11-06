#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.

=head1 Elements

=head2 Synopsis

    % parrot t/20-element.t

=cut

.sub 'main' :main
    load_bytecode 'xml.pir'

    .include 'test_more.pir'

    plan(7)

    test_start_end()
    test_start_end_with_attributes()
    test_start_end_with_duplicated_attributes()
    test_empty()
    test_empty_with_attribute()
    test_empty_with_duplicated_attributes()
    test_unbalanced_start_end()
.end

.sub 'test_start_end'
     $S1 = <<'XML'
<elt  >content</elt  >
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'start/end')
<elt>content</elt>
OUT
.end

.sub 'test_start_end_with_attributes'
     $S1 = <<'XML'
<elt a="1" b='txt' >content</elt  >
XML
     $S0 = 'xml_to_xml'($S1)
     $I1 = $S0 == <<'OUT'
<elt a="1" b="txt">content</elt>
OUT
     $I2 = $S0 == <<'OUT'
<elt b="txt" a="1">content</elt>
OUT
    $I0 = $I1 || $I2
    ok($I0, 'start/end with attributes')
.end

.sub 'test_start_end_with_duplicated_attributes'
     $S1 = <<'XML'
<elt a="1" a='txt' >content</elt  >
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, "duplicate attribute: a", 'start/end with duplicated attributes')
.end

.sub 'test_empty'
     $S1 = <<'XML'
<elt  />
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'empty')
<elt></elt>
OUT
.end

.sub 'test_empty_with_attribute'
     $S1 = <<'XML'
<elt a='1' />
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'empty with attribute')
<elt a="1"></elt>
OUT
.end

.sub 'test_empty_with_duplicated_attributes'
     $S1 = <<'XML'
<elt a='1' a='2'/>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, "duplicate attribute: a", 'empty with duplicated attributes')
.end

.sub 'test_unbalanced_start_end'
     $S1 = <<'XML'
<a><b>content</c></a>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, "unbalanced end tag: c (b expected)", 'unbalanced start/end')
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


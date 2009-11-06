#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.

=head1 Entities

=head2 Synopsis

    % parrot t/30-entity.t

=cut

.sub 'main' :main
    load_bytecode 'xml.pir'

    .include 'test_more.pir'

    plan(5)

    test_prefined_entity()
    test_character_reference_dec()
    test_character_reference_hex()
    test_internal_entity()
    test_in_attribute()
.end

.sub 'test_prefined_entity'
     $S1 = <<'XML'
<elt>2 &gt; 1</elt>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'prefined entity')
<elt>2 &gt; 1</elt>
OUT
.end

.sub 'test_character_reference_dec'
     $S1 = <<'XML'
<elt> &#65; </elt>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'character reference (dec)')
<elt> A </elt>
OUT
.end

.sub 'test_character_reference_hex'
     $S1 = <<'XML'
<elt> &#x41; </elt>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'character reference (hex)')
<elt> A </elt>
OUT
.end

.sub 'test_internal_entity'
     $S1 = <<'XML'
<?xml version='1.0'?><!DOCTYPE status [
    <!ENTITY Pub-Status "This is a pre-release of the specification">
] >
<status>&Pub-Status;</status>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'internal entity')
<?xml version="1.0"?>
<!DOCTYPE status [
  <!ENTITY Pub-Status "This is a pre-release of the specification">
]>
<status>&Pub-Status;</status>
OUT
.end

.sub 'test_in_attribute'
     $S1 = <<'XML'
<elt a="&#x31; &gt; &#48;"> &lt; </elt>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'in attribute')
<elt a="1 &gt; 0"> &lt; </elt>
OUT
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


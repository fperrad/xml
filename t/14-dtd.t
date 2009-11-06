#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.

=head1 XML Declaration

=head2 Synopsis

    % parrot t/13-xmldecl.t

=cut

.sub 'main' :main
    load_bytecode 'xml.pir'

    .include 'test_more.pir'

    plan(8)

    test_system()
    test_internal()
    test_attlist_1()
    test_attlist_2()
    test_notation()
    test_internal_entity()
    test_external_entity()
    test_parameter_entity()
.end

.sub 'test_system'
     $S1 = <<'XML'
<?xml version='1.0'?><!DOCTYPE greeting SYSTEM 'hello.dtd'><greeting>Hello, world!</greeting>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'system')
<?xml version="1.0"?>
<!DOCTYPE greeting SYSTEM "hello.dtd">
<greeting>Hello, world!</greeting>
OUT
.end

.sub 'test_internal'
     $S1 = <<'XML'
<?xml version='1.0'?><!DOCTYPE greeting [
    <!ELEMENT greeting (#PCDATA)>
] >
<greeting>Hello, world!</greeting>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'internal')
<?xml version="1.0"?>
<!DOCTYPE greeting [
  <!ELEMENT greeting (#PCDATA)>
]>
<greeting>Hello, world!</greeting>
OUT
.end

.sub 'test_attlist_1'
     $S1 = <<'XML'
<?xml version='1.0'?><!DOCTYPE greeting [
    <!ELEMENT greeting (#PCDATA)>
    <!ATTLIST greeting id ID #IMPLIED>
] >
<greeting>Hello, world!</greeting>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'attlist')
<?xml version="1.0"?>
<!DOCTYPE greeting [
  <!ELEMENT greeting (#PCDATA)>
  <!ATTLIST greeting id ID #IMPLIED>
]>
<greeting>Hello, world!</greeting>
OUT
.end

.sub 'test_attlist_2'
     $S1 = <<'XML'
<?xml version='1.0'?><!DOCTYPE form [
  <!ATTLIST termdef
            id      ID      #REQUIRED
            name    CDATA   #IMPLIED>
  <!ATTLIST list
            type    (bullets|ordered|glossary) "ordered">
  <!ATTLIST form
            method  CDATA   #FIXED "POST">
]>
<form />
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'attlist')
<?xml version="1.0"?>
<!DOCTYPE form [
  <!ATTLIST termdef id ID #REQUIRED>
  <!ATTLIST termdef name CDATA #IMPLIED>
  <!ATTLIST list type (bullets|ordered|glossary) "ordered">
  <!ATTLIST form method CDATA #FIXED "POST">
]>
<form></form>
OUT
.end

.sub 'test_notation'
     $S1 = <<'XML'
<?xml version='1.0'?><!DOCTYPE greeting [
    <!NOTATION note SYSTEM "note.txt">
] >
<greeting>Hello, world!</greeting>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'notation')
<?xml version="1.0"?>
<!DOCTYPE greeting [
  <!NOTATION note SYSTEM "note.txt">
]>
<greeting>Hello, world!</greeting>
OUT
.end

.sub 'test_internal_entity'
     $S1 = <<'XML'
<?xml version='1.0'?><!DOCTYPE greeting [
    <!ENTITY Pub-Status "This is a pre-release of the specification">
] >
<greeting>Hello, world!</greeting>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'internal entity')
<?xml version="1.0"?>
<!DOCTYPE greeting [
  <!ENTITY Pub-Status "This is a pre-release of the specification">
]>
<greeting>Hello, world!</greeting>
OUT
.end

.sub 'test_external_entity'
     $S1 = <<'XML'
<?xml version='1.0'?><!DOCTYPE greeting [
    <!ENTITY open-hatch
             SYSTEM "http://www.textuality.com/boilerplate/OpenHatch.xml">
    <!ENTITY open-hatch
             PUBLIC "-//Textuality//TEXT Standard open-hatch boilerplate//EN"
             "http://www.textuality.com/boilerplate/OpenHatch.xml">
    <!ENTITY hatch-pic
             SYSTEM "../grafix/OpenHatch.gif"
             NDATA gif >
] >
<greeting>Hello, world!</greeting>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'external entity & unparsed')
<?xml version="1.0"?>
<!DOCTYPE greeting [
  <!ENTITY open-hatch SYSTEM "http://www.textuality.com/boilerplate/OpenHatch.xml">
  <!ENTITY open-hatch PUBLIC "-//Textuality//TEXT Standard open-hatch boilerplate//EN" "http://www.textuality.com/boilerplate/OpenHatch.xml">
  <!ENTITY hatch-pic SYSTEM "../grafix/OpenHatch.gif" NDATA gif>
]>
<greeting>Hello, world!</greeting>
OUT
.end

.sub 'test_parameter_entity'
     $S1 = <<'XML'
<?xml version='1.0'?><!DOCTYPE greeting [
    <!ENTITY % core "abc">
] >
<greeting>Hello, world!</greeting>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'parameter entity')
<?xml version="1.0"?>
<!DOCTYPE greeting [
  <!ENTITY %core "abc">
]>
<greeting>Hello, world!</greeting>
OUT
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


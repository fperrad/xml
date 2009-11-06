#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.

=head1 XML Declaration

=head2 Synopsis

    % parrot t/13-xmldecl.t

=cut

.sub 'main' :main
    load_bytecode 'xml.pir'

    .include 'test_more.pir'

    plan(3)

    test_version()
    test_encoding()
    test_standalone()
.end

.sub 'test_version'
     $S1 = <<'XML'
<?xml version='1.0'?><elt>content</elt>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'version')
<?xml version="1.0"?>
<elt>content</elt>
OUT
.end

.sub 'test_encoding'
     $S1 = <<'XML'
<?xml version='1.0' encoding='utf-8'?><elt>content</elt>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'encoding')
<?xml version="1.0" encoding="utf-8"?>
<elt>content</elt>
OUT
.end

.sub 'test_standalone'
     $S1 = <<'XML'
<?xml version='1.0' standalone="yes"?><elt>content</elt>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'standalone')
<?xml version="1.0" standalone="yes"?>
<elt>content</elt>
OUT
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


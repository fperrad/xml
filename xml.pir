# Copyright (C) 2009, Parrot Foundation.

=head1 TITLE

xml.pir - A Xml demo.

=head2 Description

This program demonstrates the use of the modules :

=over

=item Xml::Sax::Xml

a XML SAX like parser

=item Handler::XmlWriter

a simple handler

=back

=cut

.namespace []

.sub 'onload' :anon :load :init
    load_bytecode 'xml/sax/xml.pbc'
    load_bytecode 'xml/handler/xmlwriter.pbc'
.end

.sub 'main' :main
    .param pmc args

    .local string filename
    $P0 = shift args # progname
    filename = shift args

    .local pmc stream
    stream = new 'StringHandle'
    stream.'open'( 'xml', 'wr' )

    .local pmc handler
    handler = new ['Xml';'Handler';'XmlWriter']
    handler.'stream'(stream)

    .local pmc driver
    driver = new [ 'Xml';'Sax';'Xml';'Compiler' ]
    driver.'handler'(handler)
    driver.'parse_file'(filename)

    $S0 = stream.'readall'()
    stream.'close'()
    say $S0
.end

.sub 'xml_to_xml'
    .param string data

    .local pmc stream
    stream = new 'StringHandle'
    stream.'open'( 'xml', 'wr' )

    .local pmc handler
    handler = new ['Xml';'Handler';'XmlWriter']
    handler.'stream'(stream)

    .local pmc driver
    driver = new [ 'Xml';'Sax';'Xml';'Compiler' ]
    driver.'handler'(handler)
    push_eh _handler
    driver.'parse_string'(data)
    pop_eh

    $S0 = stream.'readall'()
    $S0 .= "\n"
    stream.'close'()
    .return ($S0)

  _handler:
    .local pmc e
    .get_results (e)
    $S0 = e
    .return ($S0)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

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
    load_bytecode 'languages/xml/sax/xml/xml.pbc'
    load_bytecode 'languages/xml/handler/xmlwriter/xmlwriter.pbc'
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

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

# Copyright (C) 2009, Parrot Foundation.

class Xml::Handler::XmlWriter;

method start_document() {
}

method end_document() {
}

method characters( :$Data ) {
    print( $Data );
}

method comment( :$Data ) {
    print( '<!--', $Data, '-->' );
}

method processing_instruction( :$Target, :$Data ) {
    print( '<?', $Target );
    if ?$Data {
        print( ' ', $Data );
    }
    print(  '?>' );
}

method start_cdata() {
}

method end_cdata() {
}

method xml_decl( :$Version, :$Encoding, :$Standalone ) {
    print( "xml_decl", " ", $Version, " ", $Encoding, " ", $Standalone );
    print( '<?xml version="', $Version, '"' );
    if ?$Encoding {
        print( ' encoding="', $Encoding, '"' );
    }
    if ?$Standalone {
        print( ' standalone="', $Standalone, '"' );
    }
    print( '?>' )
}

method start_element( :$Name, :$Attributes ) {
    print( '<', $Name );
    print( '>' );
}

method end_element( :$Name ) {
    print( '</', $Name, '>' );
}

method entity_reference( :$Name, :$Value ) {
    print( '&', $Name, ';' );
}

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:


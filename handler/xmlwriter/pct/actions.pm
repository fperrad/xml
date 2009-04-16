# Copyright (C) 2009, Parrot Foundation.

class Xml::Handler::XmlWriter;

method start_document() {
    our $in_cdata := 0;
}

method end_document() {
}

method characters( :$Data ) {
    our $in_cdata;
    if $in_cdata {
        print( $Data );
    }
    else {
        print( escape( $Data ) );
    }
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
    our $in_cdata := 1;
    print( '<![CDATA[' );
}

method end_cdata() {
    our $in_cdata := 0;
    print( ']]>' );
}

method xml_decl( :$Version, :$Encoding, :$Standalone ) {
    print( '<?xml version="', $Version, '"' );
    if ?$Encoding {
        print( ' encoding="', $Encoding, '"' );
    }
    if ?$Standalone {
        print( ' standalone="', $Standalone, '"' );
    }
    print( '?>' )
}

method start_element( :$Name, :%Attributes ) {
    print( '<', $Name );
    for %Attributes {
        print( ' ', $_, '="', escape( %Attributes{$_} ), '"' );
    }
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


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
        print( '<![CDATA[', $Data, ']]>' );
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
}

method end_cdata() {
    our $in_cdata := 0;
}

method xml_decl( :$Version, :$Encoding, :$Standalone ) {
    print( '<?xml version="', $Version, '"' );
    if ?$Encoding {
        print( ' encoding="', $Encoding, '"' );
    }
    if ?$Standalone {
        print( ' standalone="', $Standalone, '"' );
    }
    print( '?>', "\n" );
}

method start_dtd( :$Name, :$SystemId, :$PublicId ) {
    print( '<!DOCTYPE ', $Name );
    our $first_in_dtd := 1;
    if ?$SystemId {
        if ?$PublicId {
            print( ' PUBLIC "', $PublicId, '" "', $SystemId, '"' );
        }
        else {
            print( ' SYSTEM "', $SystemId, '"' );
        }
    }
}

sub _dtd_internal() {
    our $first_in_dtd;
    if $first_in_dtd {
        print( ' [', "\n" );
        $first_in_dtd := 0
    }
}

method end_dtd() {
    our $first_in_dtd;
    unless $first_in_dtd {
        print( ']' );
    }
    print( '>', "\n" );
}

method start_element( :$Name, :%Attributes ) {
    print( '<', $Name );
    for %Attributes {
        # TODO : escape value when normalized by parser
        print( ' ', $_, '="', %Attributes{$_} , '"' );
    }
    print( '>' );
}

method end_element( :$Name ) {
    print( '</', $Name, '>' );
}

method element_decl( :$Name, :$Model ) {
    _dtd_internal();
    print( '  <!ELEMENT ', $Name, ' ', $Model, '>', "\n" );
}

method attlist_decl( :$eName, :$aName, :$Type, :$Mode, :$Value ) {
    _dtd_internal();
    print( '  <!ATTLIST ', $eName, ' ', $aName, ' ', $Type );
    if ?$Mode {
        print( ' ', $Mode );
    }
    if ?$Value {
        print( ' "', $Value, '"' );
    }
    print( '>', "\n" );
}

method entity_reference( :$Name, :$Value ) {
    print( '&', $Name, ';' );
}

method internal_entity_decl( :$Name, :$Value ) {
    _dtd_internal();
    print( '  <!ENTITY ', $Name, ' "', $Value, '">', "\n" );
}

method external_entity_decl( :$Name, :$PublicId, :$SystemId ) {
    _dtd_internal();
    print( '  <!ENTITY ', $Name );
    if ?$PublicId {
        print( ' PUBLIC "', $PublicId, '" "', $SystemId, '"' );
    }
    else {
        print( ' SYSTEM "', $SystemId, '"' );
    }
    print( '>', "\n" );
}

method unparsed_entity_decl( :$Name, :$PublicId, :$SystemId, :$Notation ) {
    _dtd_internal();
    print( '  <!ENTITY ', $Name );
    if ?$PublicId {
        print( ' PUBLIC "', $PublicId, '" "', $SystemId, '"' );
    }
    else {
        print( ' SYSTEM "', $SystemId, '"' );
    }
    print( ' NDATA ', $Notation, '>', "\n" );
}

method notation_decl( :$Name, :$PublicId, :$SystemId ) {
    _dtd_internal();
    print( '  <!NOTATION ', $Name );
    if ?$PublicId {
        print( ' PUBLIC "', $PublicId, '"' );
        if ?$SystemId {
            print( ' "', $SystemId, '"' );
        }
    }
    else {
        print( ' SYSTEM "', $SystemId, '"' );
    }
    print( '>', "\n" );
}

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

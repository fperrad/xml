# Copyright (C) 2009, Parrot Foundation.

=begin comments

Xml::Sax::Xml::Grammar::Actions - ast transformations for Xml

This file contains the methods that are used by the parse grammar
to build the PAST representation of an Xml program.
Each method below corresponds to a rule in F<src/parser/grammar.pg>,
and is invoked at the point where C<{*}> appears in the rule,
with the current match object as the first argument.  If the
line containing C<{*}> also has a C<#= key> comment, then the
value of the comment is passed as the second argument to the method.

=end comments

=cut

class Xml::Sax::Xml::Grammar::Actions;

method TOP($/) {
    make PCT::Node.new();
}

# 1
method document($/, $key) {
    our %entities;
    if ( $key eq 'start_document' ) {
        # predefined entities
        %entities{'lt'} := '<';
        %entities{'gt'} := '>';
        %entities{'amp'} := '&';
        %entities{'apos'} := "'";
        %entities{'quot'} := '"';
    }
    fire( $key );
    make PCT::Node.new();
}

# 14
method CharData($/) {
    fire( 'characters',
          :Data( $/.Str() ) );
    make PCT::Node.new();
}

# 15
method Comment($/) {
    fire( 'comment',
          :Data( $/[0] ) );
    make PCT::Node.new();
}

# 16
method PI($/) {
    fire( 'processing_instruction',
          :Target( $<PITarget> ),
          :Data( $<Data>
              ?? $<Data>[0]
              !! '' ) );
    make PCT::Node.new();
}

# 18
method CDSect($/) {
    fire( 'start_cdata' );
    fire( 'characters',
          :Data( $<CData> ) );
    fire( 'end_cdata' );
    make PCT::Node.new();
}

# 23
method XMLDecl($/) {
    fire( 'xml_decl',
          :Version( $<VersionInfo><VersionNum> ),
          :Encoding( $<EncodingDecl>
                  ?? $<EncodingDecl>[0]<EncName>
                  !! '' ),
          :Standalone( $<SDDecl>
                    ?? $<SDDecl>[0]<_yes_no>
                    !! '' ) );
    make PCT::Node.new();
}

# 28
method doctypedecl($/) {
    fire( 'doctype_decl',
          :Name( $<Name> ),
          :SystemId( $<ExternalID>[0]<SystemLiteral>
                  ?? $<ExternalID>[0]<SystemLiteral>[0]
                  !! '' ),
          :PublicId( $<ExternalID>[0]<PubidLiteral>
                  ?? $<ExternalID>[0]<PubidLiteral>[0]
                  !! '' ),
          :Internal( $<Internal>
                  ?? $<Internal>[0]
                  !! '' ) );
    make PCT::Node.new();
}

# 40
method STag($/) {
    my %attr;
    for ( $<Attribute> ) {
        %attr{ $_<Name> } := $_<AttValue>[0];
    }
    fire( 'start_element',
          :Name( $<Name> ),
          :Attributes( %attr ) );
    make PCT::Node.new();
}

# 42
method ETag($/) {
    fire( 'end_element',
          :Name( $<Name> ) );
    make PCT::Node.new();
}

# 44
method EmptyElemTag($/) {
    my %attr;
    for ( $<Attribute> ) {
        %attr{ $_<Name> } := $_<AttValue>[0];
    }
    fire( 'start_element',
          :Name( $<Name> ),
          :Attributes( %attr ) );
    fire( 'end_element',
          :Name( $<Name> ) );
    make PCT::Node.new();
}

# 45
method elementdecl($/) {
    fire( 'element_decl',
          :Name( $<Name> ),
          :Model( $<contentspec> ) );
    make PCT::Node.new();
}

# 52
method AttlistDecl($/) {
    for ( $<AttDef> ) {
        fire( 'attlist_decl',
              :eName( $<Name> ),
              :aName( $_<Name> ),
              :Type( $_<AttType> ),
              :Mode( $_<DefaultDecl><AttValue>
                  ?? $_<DefaultDecl>[0][0]
                  !! $_<DefaultDecl> ),
              :Value( $_<DefaultDecl><AttValue>
                   ?? $_<DefaultDecl><AttValue>[0]
                   !! '' ) );
    }
    make PCT::Node.new();
}

# 66
method CharRef($/, $key) {
    fire( 'characters',
          :Data( char_ref( $key, $/[0] ) ) );
    make PCT::Node.new();
}

# 67
method Reference($/, $key) {
    make $( $/{$key} );
}

# 68
method EntityRef($/) {
    our %entities;
    fire( 'entity_reference',
          :Name( $<Name> ),
          :Value( %entities{$<Name>} ) );
    make PCT::Node.new();
}

# 71
method GEDecl($/) {
    our %entities;
    if ( $<EntityDef><EntityValue> ) {
        %entities{$<Name>} := $<EntityDef><EntityValue>[0];
        fire( 'internal_entity_decl',
              :Name( $<Name> ),
              :Value( %entities{$<Name>} ) );
    }
    elsif ( $<EntityDef><NDataDecl> ) {
        fire( 'unparsed_entity_decl',
              :Name( $<Name> ),
              :PublicId( $<EntityDef><ExternalID><PubidLiteral>
                      ?? $<EntityDef><ExternalID><PubidLiteral>[0]
                      !! '' ),
              :SystemId( $<EntityDef><ExternalID><SystemLiteral>
                      ?? $<EntityDef><ExternalID><SystemLiteral>[0]
                      !! '' ),
              :Notation( $<EntityDef><NDataDecl>
                      ?? $<EntityDef><NDataDecl>[0]<Name>
                      !! '' ) );
    }
    else {
        fire( 'external_entity_decl',
              :Name( $<Name> ),
              :PublicId( $<EntityDef><ExternalID><PubidLiteral>
                      ?? $<EntityDef><ExternalID><PubidLiteral>[0]
                      !! '' ),
              :SystemId( $<EntityDef><ExternalID><SystemLiteral>
                      ?? $<EntityDef><ExternalID><SystemLiteral>[0]
                      !! '' ) );
    }
    make PCT::Node.new();
}

# 82
method NotationDecl($/) {
    fire( 'notation_decl',
          :Name( $<Name> ),
          :PublicId( $<_NotationID><PubidLiteral>
                  ?? $<_NotationID><PubidLiteral>[0]
                  !! '' ),
          :SystemId( $<_NotationID><SystemLiteral>
                  ?? $<_NotationID><SystemLiteral>[0]
                  !! '' ),
          :Base( 'TODO' ) );
    make PCT::Node.new();
}

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:


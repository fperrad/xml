#!/usr/bin/env parrot
# Copyright (C) 2009, Parrot Foundation.

=head1 NAME

setup.pir - Python distutils style

=head1 DESCRIPTION

No Configure step, no Makefile generated.

=head1 USAGE

    $ parrot setup.pir build
    $ parrot setup.pir test
    $ sudo parrot setup.pir install

=cut

.sub 'main' :main
    .param pmc args
    $S0 = shift args
    load_bytecode 'distutils.pbc'

    $P0 = new 'Hash'
    $P0['name'] = 'XML'
    $P0['abstract'] = 'XML on Parrot'
    $P0['authority'] = 'http://github.com/fperrad'
    $P0['description'] = 'some toys: a SAX like parser & a simple handler XmlWriter'
    $P5 = split ',', 'xml,sax'
    $P0['keywords'] = $P5
    $P0['license_type'] = 'Artistic License 2.0'
    $P0['license_uri'] = 'http://www.perlfoundation.org/artistic_license_2_0'
    $P0['copyright_holder'] = 'Parrot Foundation'
    $P0['checkout_uri'] = 'git://github.com/fperrad/xml.git'
    $P0['browser_uri'] = 'http://github.com/fperrad/xml'
    $P0['project_uri'] = 'http://github.com/fperrad/xml'

    # build
    $P1 = new 'Hash'
    $P1['xml/sax/xml/grammar_gen.pir'] = 'xml/sax/xml/grammar.pg'
    $P0['pir_pge'] = $P1

    $P2 = new 'Hash'
    $P2['xml/sax/xml/actions_gen.pir'] = 'xml/sax/xml/actions.nqp'
    $P2['xml/handler/xmlwriter/actions_gen.pir'] = 'xml/handler/xmlwriter/actions.nqp'
    $P0['pir_nqp-rx'] = $P2

    $P3 = new 'Hash'
    $P4 = split "\n", <<'SOURCES'
xml/sax/xml.pir
xml/sax/xml/grammar_gen.pir
xml/sax/xml/actions_gen.pir
xml/sax/xml/builtins.pir
xml/sax/xml/builtins/char_ref.pir
xml/sax/xml/builtins/fire.pir
xml/sax/xml/builtins/normalize.pir
SOURCES
    $P3['xml/sax/xml.pbc'] = $P4
    $P5 = split "\n", <<'SOURCES'
xml/handler/xmlwriter.pir
xml/handler/xmlwriter/actions_gen.pir
xml/handler/xmlwriter/builtins.pir
xml/handler/xmlwriter/builtins/escape.pir
xml/handler/xmlwriter/builtins/print.pir
xml/handler/xmlwriter/builtins/throw.pir
SOURCES
    $P3['xml/handler/xmlwriter.pbc'] = $P5
    $P0['pbc_pir'] = $P3

    # test
    $S0 = get_parrot()
    $P0['prove_exec'] = $S0

    # install
    $P6 = split ' ', 'xml/sax/xml.pbc xml/handler/xmlwriter.pbc'
    $P0['inst_lib'] = $P6

    # dist
    $P0['manifest_includes'] = 'xml.pir'

    .tailcall setup(args :flat, $P0 :flat :named)
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

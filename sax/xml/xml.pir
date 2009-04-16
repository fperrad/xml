# Copyright (C) 2009, Parrot Foundation.

=head1 TITLE

xml.pir - A Xml compiler.

=head2 Description

This is the base file for the Xml compiler.

This file includes the parsing and grammar rules from
the src/ directory, loads the relevant PGE libraries,
and registers the compiler under the name 'Xml'.

=head2 Functions

=over 4

=item onload()

Creates the Xml compiler using a C<PCT::HLLCompiler>
object.

=cut

.namespace [ 'Xml::Sax::Xml::Compiler' ]

.sub 'onload' :anon :load :init
    load_bytecode 'PCT.pbc'

    $P0 = get_hll_global ['PCT'], 'HLLCompiler'
    $P1 = $P0.'new'()
    $P1.'language'('Xml')
    $P1.'parsegrammar'('Xml::Sax::Xml::Grammar')
    $P1.'parseactions'('Xml::Sax::Xml::Grammar::Actions')
    $P1.'removestage'('evalpmc')
    $P1.'removestage'('pir')
    $P1.'removestage'('post')
.end

=item main(args :slurpy)  :main

Start compilation by passing any command line C<args>
to the Xml compiler.

=cut

.sub 'main' :main
    .param pmc args

    $P0 = compreg 'Xml'
    $P1 = $P0.'command_line'(args)
.end

.include 'sax/xml/gen_builtins.pir'
.include 'sax/xml/gen_grammar.pir'
.include 'sax/xml/gen_actions.pir'

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


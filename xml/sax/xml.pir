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

.namespace [ 'Xml';'Sax';'Xml';'Compiler' ]

.sub 'onload' :anon :load :init
    load_bytecode 'PCT.pbc'

    new $P0, 'P6metaclass'
    $P0.'new_class'('Xml::Sax::Xml::Compiler', 'attr'=>'comp')

    $P0 = get_hll_global ['PCT'], 'HLLCompiler'
    $P1 = $P0.'new'()
    $P1.'language'('Xml')
    $P1.'parsegrammar'('Xml::Sax::Xml::Grammar')
    $P1.'parseactions'('Xml::Sax::Xml::Grammar::Actions')
    $P1.'removestage'('evalpmc')
    $P1.'removestage'('pir')
    $P1.'removestage'('post')
.end

.sub 'init' :method :vtable
    $P0 = compreg 'Xml'
    self.'comp'($P0)
.end

.sub 'attr' :method
    .param string attrname
    .param pmc value
    .param int has_value
    if has_value goto set_value
    value = getattribute self, attrname
    unless null value goto end
    value = new 'Undef'
    goto end
  set_value:
    setattribute self, attrname, value
  end:
    .return (value)
.end

.sub 'comp' :method
    .param pmc value           :optional
    .param int has_value       :opt_flag
    .tailcall self.'attr'('comp', value, has_value)
.end

.sub 'handler' :method
    .param pmc value           :optional
    .param int has_value       :opt_flag
    if has_value goto set_value
    value = get_hll_global [ 'Xml';'Sax';'Xml';'Compiler' ], 'Handler'
    unless null value goto end
    value = new 'Undef'
    goto end
  set_value:
    set_hll_global [ 'Xml';'Sax';'Xml';'Compiler' ], 'Handler', value
  end:
    .return (value)
.end

.sub 'parse' :method
    .param pmc source
    $P0 = self.'comp'()
    .tailcall $P0.'parse'(source)
.end

.sub 'parse_string' :method
    .param pmc source
    .tailcall self.'parse'(source)
.end

.sub 'parse_file' :method
    .param pmc stream
    $P0 = new 'FileHandle'
    $S0 = $P0.'readall'(stream)
    $P0.'close'()
    .tailcall self.'parse'($S0)
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

.include 'xml/sax/xml/builtins.pir'
.include 'xml/sax/xml/grammar_gen.pir'
.include 'xml/sax/xml/actions_gen.pir'

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


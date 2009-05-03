# Copyright (C) 2009, Parrot Foundation.

.namespace []

.sub 'fire'
    .param string event
    .param pmc args :slurpy :named
    $P0 = get_hll_global [ 'Xml';'Sax';'Xml';'Compiler' ], 'Handler'
    if null $P0 goto L1
    $P1 = find_method $P0, event
    .tailcall $P1($P0, args :named :flat)
  L1:
    print event
    .local pmc iter
    iter = new 'Iterator', args
  iter_loop:
    unless iter goto iter_end
    $S0 = shift iter
    print ' '
    print $S0
    print '='
    $S1 = args[$S0]
    print $S1
    goto iter_loop
  iter_end:
    print "\n"
    .return ()
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


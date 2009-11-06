# Copyright (C) 2009, Parrot Foundation.

.namespace []

.sub 'print'
    .param pmc args            :slurpy
    .local pmc stream
    stream = get_hll_global [ 'Xml';'Handler';'XmlWriter' ], 'Stream'
    .local pmc it
    it = iter args
  iter_loop:
    unless it goto iter_end
    $P0 = shift it
    stream.'print'($P0)
    goto iter_loop
  iter_end:
    .return ()
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


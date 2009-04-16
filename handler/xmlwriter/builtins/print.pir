# Copyright (C) 2009, Parrot Foundation.

.namespace []

.sub 'print'
    .param pmc args            :slurpy
    .local pmc stream
    stream = get_global 'Stream'
    .local pmc iter
    iter = new 'Iterator', args
  iter_loop:
    unless iter goto iter_end
    $P0 = shift iter
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


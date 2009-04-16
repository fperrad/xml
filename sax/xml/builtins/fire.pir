# Copyright (C) 2009, Parrot Foundation.

.namespace []

.sub 'fire'
    .param string event
    .param pmc args :slurpy :named
    $P0 = get_global 'Handler'
    $P1 = find_method $P0, event
    $P1($P0, args :named :flat)
    .return ()
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


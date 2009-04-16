# Copyright (C) 2009, Parrot Foundation.

.namespace []

.sub 'escape'
    .param string str
    $P0 = split '&', str
    str = join '&amp;', $P0
    $P0 = split '<', str
    str = join '&lt;', $P0
    $P0 = split '>', str
    str = join '&gt;', $P0
    $P0 = split '"', str
    str = join '&quot;', $P0
    $P0 = split "'", str
    str = join '&apos;', $P0
    .return (str)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


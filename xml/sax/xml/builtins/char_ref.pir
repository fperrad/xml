# Copyright (C) 2009, Parrot Foundation.

.namespace []

.sub 'char_ref'
    .param string type
    .param string value
    unless type == 'dec' goto L1
    $I0 = value
    goto L2
  L1:
    value = upcase value
    $I0 = 0
    .local int pos
    pos = 0
  L3:
    $S0 = substr value, pos, 1
    $I1 = index '0123456789ABCDEF', $S0
    if $I1 < 0 goto L2
    $I0 *= 16
    $I0 += $I1
    inc pos
    goto L3
  L2:
    $S0 = chr $I0
    .return ( $S0 )
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


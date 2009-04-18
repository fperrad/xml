# Copyright (C) 2009, Parrot Foundation.

.namespace []

.sub 'normalize'
    .param string str
    .local string res
    res = ''
    .local int pos, lastpos
    pos = 0
    lastpos = length str
  L1:
    $S0 = substr str, pos, 1
    unless $S0 == '&' goto L_char
    inc pos
    $S0 = substr str, pos, 1
    unless $S0 == '#' goto L_name
    inc pos
    $I0 = 0
    $S0 = substr str, pos, 1
    unless $S0 == 'x' goto L_dec
    inc pos
  L_hex:
    $S0 = substr str, pos, 1
    $S0 = upcase $S0
    $I1 = index '0123456789ABCDEF', $S0
    if $I1 < 0 goto L2
    $I0 *= 16
    $I0 += $I1
    inc pos
    goto L_hex
  L2:
    $S0 = chr $I0
    goto L_char
  L_dec:
    $S0 = substr str, pos, 1
    $I1 = index '0123456789', $S0
    if $I1 < 0 goto L3
    $I0 *= 10
    $I0 += $I1
    inc pos
    goto L_dec
  L3:
    $S0 = chr $I0
    goto L_char
  L_name:
    .local string name
    $I1 = index str, ';', pos
    $I0 = $I1 - pos
    name = substr str, pos, $I0
    pos = $I1
    $P0 = get_global ['Xml';'Sax';'Xml';'Grammar';'Actions'], '%entities'
    $S0 = $P0[name]
  L_char:
    res .= $S0
    inc pos
    unless pos == lastpos goto L1
    .return ( res )
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


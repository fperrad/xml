# Copyright (C) 2009, Parrot Foundation.

.namespace []

.sub 'throw'
    .param string type
    .param string msg
    die msg
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


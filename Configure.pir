#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.

.include 'iglobals.pasm'

.sub 'main' :main
    load_bytecode 'Configure.pbc'

    .local pmc config
    $P0 = getinterp
    config = $P0[.IGLOBALS_CONFIG_HASH]

    # Here, do the job
    push_eh _handler
    genfile('Makefile.in', 'Makefile', config)
    pop_eh
    end

  _handler:
    .local pmc e
    .local string msg
    .get_results (e)
    printerr "\n"
    msg = e
    printerr msg
    printerr "\n"
    end
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


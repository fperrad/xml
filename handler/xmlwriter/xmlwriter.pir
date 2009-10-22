# Copyright (C) 2009, Parrot Foundation.

.namespace [ 'Xml';'Handler';'XmlWriter' ]

.sub 'onload' :anon :load :init
    load_bytecode 'PCT.pbc'
.end

.sub 'stream' :method
    .param pmc value           :optional
    .param int has_value       :opt_flag
    if has_value goto set_value
    value = get_hll_global [ 'Xml';'Handler';'XmlWriter' ], 'Stream'
    unless null value goto end
    value = new 'Undef'
    goto end
  set_value:
    set_hll_global [ 'Xml';'Handler';'XmlWriter' ], 'Stream', value
  end:
    .return (value)
.end

.include 'handler/xmlwriter/gen_builtins.pir'
.include 'handler/xmlwriter/gen_actions.pir'

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


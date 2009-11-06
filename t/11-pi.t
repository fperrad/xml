#! /usr/local/bin/parrot
# Copyright (C) 2009, Parrot Foundation.

=head1 Processing Instruction

=head2 Synopsis

    % parrot t/11-pi.t

=cut

.sub 'main' :main
    load_bytecode 'xml.pir'

    .include 'test_more.pir'

    plan(2)

    test_1()
    test_2()
.end

.sub 'test_1'
     $S1 = <<'XML'
<?first_pi?><elt><?other_pi?></elt><?final_pi?>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, $S1, 'some PI')
.end

.sub 'test_2'
     $S1 = <<'XML'
<?first_pi 42?><elt><?other_pi   with many words  ?></elt><?final_pi   42?>
XML
     $S0 = 'xml_to_xml'($S1)
     is($S0, <<'OUT', 'with data')
<?first_pi 42?><elt><?other_pi with many words  ?></elt><?final_pi 42?>
OUT
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


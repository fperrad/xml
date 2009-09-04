# Copyright (C) 2009, Parrot Foundation.

package Parrot::Test::Xml;

require Parrot::Test;

=head1 Testing routines specific to 'Xml'.

=head2 Description

Call 'Xml'.

=head2 Methods

=head3 new

Yet another constructor.

=cut

use strict;
use warnings;

use File::Spec;

sub new {
    return bless {};
}

my %language_test_map = (
    output_is   => 'is_eq',
    output_like => 'like',
    output_isnt => 'isnt_eq',
);

foreach my $func ( keys %language_test_map ) {
    no strict 'refs';

    *{"Parrot::Test::Xml::$func"} = sub {
        my $self = shift;
        my ( $code, $output, $desc, %options ) = @_;

        my $count = $self->{builder}->current_test + 1;

        my $params = $options{params} || q{};

        my $parrot = File::Spec->catfile( $self->{relpath}, $self->{parrot} );
        # flatten filenames (don't use directories)
        my $lang_fn = File::Spec->rel2abs( Parrot::Test::per_test( '.xml', $count ) );
        my $out_fn = File::Spec->rel2abs( Parrot::Test::per_test( '.out', $count ) );
        my @test_prog = (
            "$parrot xml.pbc $lang_fn",
        );

        # This does not create byte code, but lua code
        Parrot::Test::write_code_to_file( $code, $lang_fn )
            if (defined $code);

        # STDERR is written into same output file
        my $exit_code = Parrot::Test::run_command(
            \@test_prog,
            STDOUT => $out_fn,
            STDERR => $out_fn,
        );

        my $builder_func = $language_test_map{$func};

        # set a todo-item for Test::Builder to find
        my $call_pkg = $self->{builder}->exported_to() || '';

        local *{ $call_pkg . '::TODO' } = ## no critic Variables::ProhibitConditionalDeclarations
                        \$options{todo} if defined $options{todo};

        # That's the reason for:   no strict 'refs';
        my $pass =
            $self->{builder}
            ->$builder_func( Parrot::Test::slurp_file($out_fn), $output, $desc );
        unless ($pass) {
            my $diag = q{};
            my $test_prog = join ' && ', @test_prog;
            $diag .= "'$test_prog' failed with exit code $exit_code."
                if $exit_code;
            $self->{builder}->diag($diag) if $diag;
        }

        # The generated files are left in the t/* directories.
        # Let 'make clean' and 'svn:ignore' take care of them.

        return $pass;
        }
}

=head2 History

Mostly taken from F<languages/lua/t/Parrot/Test/Markdown.pm>.

=cut

1;

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:


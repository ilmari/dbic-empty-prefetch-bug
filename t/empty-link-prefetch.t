use strict;
use warnings;

use Test::More;
use Test::Deep;

use MySchema;

my $schema = MySchema->connect("dbi:SQLite::memory:");
$schema->deploy;

$schema->resultset('Foo')->create({});

my $foo_rs = $schema->resultset('Foo')->search({}, { prefetch => { bars => 'baz' } });

my ($foo) = $foo_rs->all;

$schema->storage->debugcb(sub { fail "no db hit"; diag $_[1] });
$schema->storage->debug(1);

test_prefetch($foo);

$schema->storage->debug(0);

diag "creating related baz";
$foo->add_to_bazes({});

$foo_rs = $schema->resultset('Foo')->search({}, { prefetch => { bars => 'baz' } });
($foo) = $foo_rs->all;

$schema->storage->debug(1);

test_prefetch($foo);

sub test_prefetch {
    my ($foo) = @_;

    my $bar_rs = $foo->bars;
    ok $bar_rs->get_cache, 'bar cache';

    my @bars = $bar_rs->all;

    my $baz_rs = $bar_rs->related_resultset('baz');

    ok $baz_rs->get_cache, 'baz cache';

    my @bazes = $baz_rs->all;
}

done_testing;

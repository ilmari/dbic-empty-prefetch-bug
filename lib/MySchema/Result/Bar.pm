package MySchema::Result::Bar;

use DBIx::Class::Candy -autotable => v1;

column foo_id => {
    data_type => 'integer',
    is_nullable => 0,
};

column baz_id => {
    data_type => 'integer',
    is_nullable => 0,
};

primary_key(qw(foo_id baz_id));

belongs_to foo => 'MySchema::Result::Foo', 'foo_id';

belongs_to baz => 'MySchema::Result::Baz', 'baz_id';

1;

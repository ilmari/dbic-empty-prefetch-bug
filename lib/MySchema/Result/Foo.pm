package MySchema::Result::Foo;

use DBIx::Class::Candy -autotable => v1;

primary_column id => {
    data_type => 'integer',
    is_auto_increment => 1,
};

has_many bars => 'MySchema::Result::Bar', 'foo_id';

# Only used for creating related rows
many_to_many bazes => bars => 'baz';

1;

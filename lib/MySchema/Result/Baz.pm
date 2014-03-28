package MySchema::Result::Baz;

use DBIx::Class::Candy -autotable => v1;

primary_column id => {
    data_type => 'integer',
    is_auto_increment => 1,
};

1;

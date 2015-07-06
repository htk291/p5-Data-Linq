use strict;
use Test::More;
use Data::Linq;

my $data = [];

my $linq = enumerable($data);

can_ok($linq, qw/
    aggregate
    all
    any
    as_enumerable
    average
    cast
    contains
    count
    default_if_empty
    element_at
    element_at_or_default
    empty
    first
    first_or_default
    last
    last_or_default
    long_count
    max
    min
    of_type
    range
    repeat
    select
    select_many
    sequence_equal
    single
    single_or_default
    sum
    to_array
    to_dictionary
    to_list
    to_lookup
    where
/);

done_testing;

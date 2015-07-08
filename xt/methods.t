use strict;
use Test::More;
use Data::Linq;

my $data = [];

my $linq = enumerable($data);

can_ok($linq, qw/
    aggregate
    all
    any
    average
    contains
    count
    default_if_empty
    element_at
    empty
    first
    last
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
    sum
    to_array
    to_dictionary
    to_list
    to_lookup
    where
/);

done_testing;

use strict;
use Test::More;
use Data::Linq;

subtest 'range with 1 arg' => sub {
    my @range = enumerable()->range(5)->to_array;
    is_deeply [@range], [0,1,2,3,4];
};

subtest 'range with 2 args' => sub {
    my @range = enumerable()->range(5, 4)->to_array;
    is_deeply [@range], [5,6,7,8];
};

subtest 'repeat' => sub {
    my @repeat = enumerable()->repeat('Yokohama', 4)->to_array;
    is_deeply [@repeat], ['Yokohama','Yokohama','Yokohama','Yokohama'];
};

subtest 'empty' => sub {
    my @empty = enumerable()->empty->to_array;
    is_deeply [@empty], [];
};

done_testing;


use strict;
use Test::More;
use Data::Linq;

my $x = enumerable([qw[1 2 2 3 3]]);
my $y = enumerable([qw[2 3 3 4 4 5]]);

subtest 'distinct' => sub {
    my @array = $x->distinct->to_array;
    is_deeply [@array], [qw[1 2 3]];
};

subtest 'union' => sub {
    my @array = $x->union($y)->to_array;
    is_deeply [@array], [qw[1 2 3 4 5]];
};

subtest 'intersect' => sub {
    my @array = $x->intersect($y)->to_array;
    is_deeply [@array], [qw[2 3]];
};

subtest 'except' => sub {
    my @array = $x->except($y)->to_array;
    is_deeply [@array], [qw[1]];
};


done_testing;

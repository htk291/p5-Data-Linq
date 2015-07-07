use strict;
use Test::More;
use Data::Linq;

my $x = enumerable([qw[1 1 2 2 3 3]]);
my $y = enumerable([qw[a b c d e]]);

subtest 'concat with 1 arg' => sub {
    my @array = $x->concat($y)->to_array;
    is_deeply [@array], [qw[1 1 2 2 3 3 a b c d e]];
};

subtest 'concat with 2 args' => sub {
    my @array = enumerable()->concat($x, $y)->to_array;
    is_deeply [@array], [qw[1 1 2 2 3 3 a b c d e]];
};

done_testing;

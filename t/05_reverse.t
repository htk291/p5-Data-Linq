use strict;
use Test::More;
use Data::Linq;

my $x = enumerable([qw[hoge fuga piyo pooh]]);

subtest 'reverse' => sub {
    my @array = $x->reverse->to_array;
    is_deeply [@array], [qw[pooh piyo fuga hoge]];
};

done_testing;

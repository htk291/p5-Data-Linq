use strict;
use Test::More;
use Data::Linq;

my $x = enumerable([qw[hoge fuga piyo]]);
my $y = enumerable([qw[hoge fuga piyo]]);
my $z = enumerable([qw[hoge piyo]]);

subtest 'sequence_equal' => sub {
    ok $x->sequence_equal($y);
    ok !$x->sequence_equal($z);
};

done_testing;

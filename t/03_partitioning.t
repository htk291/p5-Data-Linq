use strict;
use Test::More;
use Data::Linq;

my @list = (qw(hoge fuga piyo moge foo bar baz));

subtest 'take' => sub {
    my @array = enumerable([@list])->take(3)->to_array;
    is_deeply [@array], [qw[hoge fuga piyo]];
};

subtest 'skip' => sub {
    my @array = enumerable([@list])->skip(4)->to_array;
    is_deeply [@array], [qw[foo bar baz]];
};

subtest 'take_while' => sub {
    my @array = enumerable([@list])->take_while(sub {length($_) == 4})->to_array;
    is_deeply [@array], [qw[hoge fuga piyo moge]];
};

subtest 'skip_while' => sub {
    my @array = enumerable([@list])->skip_while(sub {length($_) == 4})->to_array;
    is_deeply [@array], [qw[foo bar baz]];
};

done_testing;

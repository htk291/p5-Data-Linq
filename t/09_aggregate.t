use strict;
use warnings;
use Data::Linq;
use Test::More;

my $mh = [
        { user => { id => 1,  name => 'Sherlock' }, toys => 'Psychokinesis' },
        { user => { id => 2,  name => 'Nero'     }, toys => 'Direct Hack'   },
        { user => { id => 3,  name => 'Elly'     }, toys => 'Tri-Ascend'    },
        { user => { id => 4,  name => 'Cordelia' }, toys => 'Hyper Sensitive' },
];

subtest 'aggregate' => sub {
    my $id_max_user = enumerable($mh)->aggregate(sub {$a->{user}{id} > $b->{user}{id} ? $a : $b});
    is $id_max_user->{user}{id}, 4;
};

subtest 'count' => sub {
    is enumerable($mh)->count, 4;
};

subtest 'sum' => sub {
    is enumerable($mh)->select(sub{$_->{user}{id}})->sum, 10;
};

subtest 'average' => sub {
    is enumerable($mh)->select(sub{$_->{user}{id}})->average, 2.5;
};

subtest 'max' => sub {
    my $max_id = enumerable($mh)->select(sub{$_->{user}{id}})->max;
    is $max_id, 4;
};

subtest 'min' => sub {
    my $max_id = enumerable($mh)->select(sub{$_->{user}{id}})->min;
    is $max_id, 1;
};


done_testing;

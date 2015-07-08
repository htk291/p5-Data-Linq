use strict;
use Test::More;
use Data::Linq;

my $x = enumerable([qw[1 2 3 4 5 6]]);
my $y = enumerable([qw[2 4 6 8 10 12]]);
my $mh = enumerable(
    { user => { id => 1,  name => 'Sherlock' }, toys => 'Psychokinesis' },
    { user => { id => 2,  name => 'Nero'     }, toys => 'Direct Hack'   },
    { user => { id => 3,  name => 'Elly'     }, toys => 'Tri-Ascend'    },
    { user => { id => 4,  name => 'Cordelia' }, toys => 'Hyper Sensitive' },
);

subtest 'any' => sub {
    ok $x->any(sub{$_ % 2 == 0});
    ok $y->any(sub{$_ % 2 == 0});
    ok $x->any(sub{($_ + 1) % 2 == 0});
    ok ! $y->any(sub{($_ + 1) % 2 == 0});
};

subtest 'all' => sub {
    ok ! $x->all(sub{$_ % 2 == 0});
    ok $y->all(sub{$_ % 2 == 0});
    ok ! $x->all(sub{($_ + 1) % 2 == 0});
    ok ! $y->all(sub{($_ + 1) % 2 == 0});
};

subtest 'contains' => sub {
    ok $x->contains(5);
    ok $mh->contains({ user => { id => 3, name => 'Elly'}, toys => 'Tri-Ascend'});
    ok ! $mh->contains({ user => { id => 5, name => 'Elly'}, toys => 'Tri-Ascend'});
};


done_testing;

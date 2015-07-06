use strict;
use warnings;
use Data::Linq;
use Test::More;
use Data::Dumper;

my $mh = [
        { user => { id => 1,  name => 'Sherlock' }, toys => 'Psychokinesis' },
        { user => { id => 2,  name => 'Nero'     }, toys => 'Direct Hack'   },
        { user => { id => 3,  name => 'Elly'     }, toys => 'Tri-Ascend'    },
        { user => { id => 4,  name => 'Cordelia' }, toys => 'Hyper Sensitive' },
];
my $feathers = [
        { user => { id => 5,  name => 'Kazumi'   }, toys => 'Arrow' },
        { user => { id => 6,  name => 'Alice'    }, toys => 'Bound' },
];
my $g4 = [
        { user => { id => 7,  name => 'Kokoro'   }, IQ => 1300 },
        { user => { id => 8,  name => 'Tsugiko'  } },
        { user => { id => 9,  name => 'Hirano'   } },
        { user => { id => 10, name => 'Saku'     } },
];

subtest 'enumerable' => sub {
    subtest 'enumerable(ARRAY_REF)' => sub {
        my $list = enumerable($mh);

        isa_ok $list, "Data::Linq::Enumerable";
    };
    subtest 'enumerable(HASH_REFS)' => sub {
        my $list = enumerable(@$mh);

        isa_ok $list, "Data::Linq::Enumerable";
    };
};

subtest 'size' => sub {
    subtest 'enumerable($obj)->size' => sub {
        is enumerable($feathers)->size, 2;
    };

    subtest 'enumerable(@$obj)->size' => sub {
        is enumerable(@$g4)->size, 4;
    };
};

subtest 'to_array' => sub {
    subtest 'get array' => sub {
        my @kokoro_chan = enumerable($g4)->first->to_array;
        is_deeply @kokoro_chan, +({ user => { id => 7, name => 'Kokoro'  }, IQ => 1300 });
    };
    subtest 'get scalars' => sub {
        my ($kazumi, $alice) = enumerable($feathers)->to_array;
        is $alice->{toys}, 'Bound';
    };
};

subtest 'to_arrayref' => sub {
    my $member = enumerable($g4)->first->to_arrayref;
    my ($kokoro_chan) = @$member;
    is $kokoro_chan->{IQ}, 1300;
};

subtest 'first' => sub {
    is_deeply enumerable($g4)->first->to_arrayref, [{ user => { id => 7, name => 'Kokoro' }, IQ => 1300 }];
};

subtest 'last' => sub {
    is_deeply enumerable($g4)->last->to_array, { user => { id => 10, name => 'Saku' } };
};

subtest 'where' => sub {
    subtest 'compare strings' => sub {
        my @res_array = enumerable($mh)->where(toys => 'Psychokinesis')->to_array;
        for my $r (@res_array) {
            is $r->{user}{name}, 'Sherlock';
        }
    };
    subtest 'compare numbers' => sub {
        my @res_array = enumerable($mh)->where(toys => 'Hyper Sensitive')->to_array;
        for my $r (@res_array) {
            is $r->{user}{id}, 4;
        }
    };
    subtest 'compare undef values' => sub {
        my @res_array = enumerable(@$mh, @$g4)->where(toys => undef)->to_array;
        is_deeply \@res_array, $g4;
    };
};


subtest 'aggregate' => sub {
    my $id_max_user = enumerable($mh)->aggregate(sub {$a->{user}{id} > $b->{user}{id} ? $a : $b});
    is $id_max_user->{user}{id}, 4;
};

done_testing;


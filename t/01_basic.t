use strict;
use warnings;
use Data::Linq;
use Test::More;
use Test::Warn;

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
    subtest 'enumerable(undef)' => sub {
        my $list = enumerable();

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

subtest 'to_dictionary' => sub {
    my $dict = enumerable($mh)->to_dictionary(sub {$_->{user}{name}});
    is $dict->{Nero}{toys}, 'Direct Hack';
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


subtest 'select' => sub {
    my @names = enumerable($mh)->select(sub{$_->{user}{name}})->to_array;
    is_deeply [@names], ['Sherlock', 'Nero', 'Elly', 'Cordelia'];
};

subtest 'to_lookup' => sub {
    my $lookup = enumerable([@$mh, @$feathers, @$g4])->to_lookup(sub {substr($_->{user}{name}, 0, 1)});
    is_deeply $lookup->{K}->select(sub{$_->{user}{name}})->to_arrayref, ['Kazumi', 'Kokoro']; 
};

subtest 'single' => sub {
    my $row = enumerable($mh)->single(sub {$_->{user}{id} == 3});
    isa_ok $row, 'HASH';
    is $row->{user}{id}, 3;
    
    warning_is { enumerable($mh)->single(sub {$_->{user}{id}}) } {carped => 'multiple items matched'};
};

done_testing;


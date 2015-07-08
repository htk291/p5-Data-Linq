package Data::Linq::Enumerable;
use 5.008005;
use strict;
use warnings;

use Params::Validate qw/ :all /;
use Scalar::Util qw/ looks_like_number /;
use Carp ();
use List::Util ();
use List::MoreUtils ();
use Test::Deep::NoTest;

our $VERSION = "0.01";

sub new {
    my $self = shift;
    my ($list) = @_;

    ($list) = 
        ! defined $list ? [] :
        ref $list eq "HASH" ? [@_] : 
        @_
    ;
    my $class = ref $self || $self;
    bless $list, $class;
}

sub to_array {
    my $self = shift;
    return @$self;
}

sub to_arrayref {
    my $self = shift;
    return [@$self];
}

sub to_dictionary {
    my ($self, $code) = @_;
    my $caller = caller;
    +{(
        map {
            no strict;
            local ${$caller.'::_'} = $_;
            ($code->() => $_);
        } $self->to_array
    )};
}

sub to_lookup {
    my ($self, $code) = @_;
    my $caller = caller;
    my $dict = {};
    my $key;
    no strict;
    for my $item ($self->to_array) {
        ${$caller.'::_'} = $item;
        $key = $code->();
        $dict->{$key} ||= [];
        push @{$dict->{$key}}, $item;
    }
    $dict->{$_} = $self->new($dict->{$_}) for keys %$dict;
    $dict;
}

sub first {
    my $self = shift;
    $self->new( $self->[0] );
}

sub last {
    my $self = shift;
    $self->new( $self->[$#$self] );
}

sub size {
    my $self = shift;
    scalar @$self;
}

sub select {
    my ($self, $code) = @_;
    my $caller = caller();
    no strict;
    local ${$caller.'::_'} = $_;
    $self->new([ map {$code->()} $self->to_array ]);
}

sub where {
    my ($self, $key, $val) = @_;

    my @ret = ();
    for (@{$self->to_arrayref}) {
        if (!defined $val) {
            push (@ret, $_) if (!defined $_->{$key});
        }
        elsif (looks_like_number($val)) {
            push (@ret, $_) if ($_->{$key} == $val);
        }
        else {
            push (@ret, $_) if ($_->{$key} eq $val);
        }
    }
    return $self->new(@ret);
}

sub aggregate {
    my ($self, $code) = @_;
    my $caller = caller();
    my @rows = $self->to_array;
    my $rtn;
    for (my $i = 0; $i <= $#rows-1; $i++) {
        my $j = $i + 1;
        no strict;
        local ${$caller.'::a'} = $rtn || $rows[$i];
        local ${$caller.'::b'} = $rows[$j];
        $rtn = $code->();
    }
    return $rtn;
}

sub max {
    my ($self) = @_;
    $self->aggregate(sub {$a > $b ? $a : $b});
}

sub min {
    my ($self) = @_;
    $self->aggregate(sub {$a > $b ? $b : $a});
}

### generate methods

sub range {
    my $self = shift;
    my ($offset, $range) = 
        scalar @_ == 2 ? ($_[0], $_[1]-1) : 
        (0, $_[0]-1) 
    ;
    my $last = $offset + $range;
    $self->new([$offset .. $last]);
}

sub repeat {
    my ($self, $item, $range) = @_;
    $self->new([map {$item} 1 .. $range]);
}

sub empty {
    shift->new();
}

### partitioning methods

sub take {
    my ($self, $num) = @_;
    my @list = $self->to_array;
    $self->new([@list[0..$num-1]]);
}

sub skip {
    my ($self, $num) = @_;
    my @list = $self->to_array;
    $self->new([@list[$num..$#list]]);
}

sub take_while {
    my ($self, $code) = @_;
    my @list = $self->to_array;
    my @newlist;
    my $caller = caller;
    for my $item (@list) {
        no strict;
        local ${$caller.'::_'} = $item;
        last unless $code->();
        push @newlist, $item;
    }
    $self->new([@newlist]);
}

sub skip_while {
    my ($self, $code) = @_;
    my @list = $self->to_array;
    my @newlist;
    my $caller = caller;
    for my $item (@list) {
        no strict;
        local ${$caller.'::_'} = $item;
        next if $code->();
        push @newlist, $item;
    }
    $self->new([@newlist]);
}

### concatenation method

sub concat {
    my $self = shift; 
    scalar @_ == 2 ? 
        $self->new([map {$_->to_array} @_]) :
        $self->new([$self->to_array, $_[0]->to_array])
    ;
}

### reverse sequence method

sub reverse {
    my $self = shift;
    $self->new([CORE::reverse($self->to_array)]);
}

### set methods

sub distinct {
    my $self = shift;
    $self->new([List::MoreUtils::distinct($self->to_array)]);
}

sub union {
    my ($self, $enum) = @_;
    $self->new([$self->concat($enum)->to_array])->distinct;
}

sub intersect {
    my ($self, $enum) = @_;
    my @list = $self->to_array;
    my @newlist;
    for my $item ($enum->to_array) {
        push @newlist, grep {eq_deeply($item, $_)} @list;
    }
    $self->new([@newlist])->distinct;
}

sub except {
    my ($self, $enum) = @_;
    my @list = $self->to_array;
    for my $item ($self->intersect($enum)->to_array) {
        @list = grep {!eq_deeply($item, $_)} @list;
    }
    $self->new([@list])->distinct;
}

### sequence equal method

sub sequence_equal {
    my ($self, $enum) = @_;
    eq_deeply($self, $enum);
}

1;

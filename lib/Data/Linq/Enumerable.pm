package Data::Linq::Enumerable;
use 5.008005;
use strict;
use warnings;

use Params::Validate qw/ :all /;
use Scalar::Util qw/ looks_like_number /;
use Data::Dumper;
use Carp ();
use List::Util ();

our $VERSION = "0.01";

sub new {
    my $self = shift;
    my ($list) = @_;

    ($list) = ref $list eq "HASH" ? [@_] : @_;
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
    my($self) = @_;
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

1;

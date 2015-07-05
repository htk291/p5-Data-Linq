package Data::Linq;
use 5.008001;
use strict;
use warnings;
use Data::Linq::Enumerable;
use Exporter::Lite;

our $VERSION = "0.01";
our @EXPORT = qw/ enumerable /;

# Using Subroutine Prototype
sub enumerable {
    Data::Linq::Enumerable->new(@_);
}


1;
__END__

=encoding utf-8

=head1 NAME

Data::Linq - LINQ for Perl

=head1 SYNOPSIS

    use Data::Linq;

    my $mh = [
        { user => { id => 1, name => 'Sherlock' }, toys => 'Psychokinesis' },
        { user => { id => 2, name => 'Nero' },     toys => 'Direct Hack' },
        { user => { id => 3, name => 'Elly' },     toys => 'Tri-Ascend' },
        { user => { id => 4, name => 'Cordelia' }, toys => 'Hyper Sensitive' },
    ];

    my $result = enumerable(@$mh)->where(user => {id => { '>' => 3})
                                 ->select('toys')->to_array; # $result => ['Try-Ascend', 'Hyper Sensitive']

=head1 DESCRIPTION

.NET's LINQ for Perl, Inspired from linq.js

=head1 NOTE

THIS MODULE IS UNDER-DEVELOPMENT  
Please send issue and/or pull-request casually.

=head1 METHOD

.NET's Linq Standard Methods (Some may delete/add)

=over 4

=item * aggregate

=item * all

=item * any

=item * as_enumerable

=item * average

=item * cast

=item * contains

=item * count

=item * default_if_empty

=item * element_at

=item * element_at_or_default

=item * empty

=item * first

=item * first_or_default

=item * last

=item * last_or_default

=item * long_count

=item * max

=item * min

=item * of_type

=item * range

=item * repeat

=item * select

=item * select_many

=item * sequence_equal

=item * single

=item * single_or_default

=item * sum

=item * to_array

=item * to_dictionary

=item * to_list

=item * to_lookup

=item * where

=back

=head1 SEE ALSO

=over 4

=item * LINQ - .NET 統合言語クエリ

L<http://msdn.microsoft.com/ja-jp/library/bb308959.aspx>

=item * linq.js - LINQ for JavaScript

L<http://linqjs.codeplex.com/>

=back

=head1 LICENSE

Copyright (C) htk291

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

htk291 E<lt>htk291@gmail.comE<gt>

=cut


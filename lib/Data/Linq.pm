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

Data::Linq - It's new $module

=head1 SYNOPSIS

    use Data::Linq;

=head1 DESCRIPTION

Data::Linq is ...

=head1 LICENSE

Copyright (C) htk291.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

htk291 E<lt>htk291@gmail.comE<gt>

=cut


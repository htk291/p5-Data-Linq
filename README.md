[![Build Status](https://travis-ci.org/htk291/p5-Data-Linq.png?branch=master)](https://travis-ci.org/htk291/p5-Data-Linq) [![Coverage Status](https://coveralls.io/repos/htk291/p5-Data-Linq/badge.png?branch=master)](https://coveralls.io/r/htk291/p5-Data-Linq?branch=master)
# NAME

Data::Linq - LINQ for Perl

# SYNOPSIS

    use Data::Linq;

    my $mh = [
        { user => { id => 1, name => 'Sherlock' }, toys => 'Psychokinesis' },
        { user => { id => 2, name => 'Nero' },     toys => 'Direct Hack' },
        { user => { id => 3, name => 'Elly' },     toys => 'Tri-Ascend' },
        { user => { id => 4, name => 'Cordelia' }, toys => 'Hyper Sensitive' },
    ];

    my $result = enumerable(@$mh)->where(user => {id => { '>' => 3})
                                 ->select('toys')->to_array; # $result => ['Try-Ascend', 'Hyper Sensitive']

# DESCRIPTION

.NET's LINQ for Perl, Inspired from linq.js

# NOTE

THIS MODULE IS UNDER-DEVELOPMENT  
Please send issue and/or pull-request casually.

# METHOD

.NET's Linq Standard Methods (Some may delete/add)

- aggregate
- all
- any
- as\_enumerable
- average
- cast
- contains
- count
- default\_if\_empty
- element\_at
- element\_at\_or\_default
- empty
- first
- first\_or\_default
- last
- last\_or\_default
- long\_count
- max
- min
- of\_type
- range
- repeat
- select
- select\_many
- sequence\_equal
- single
- single\_or\_default
- sum
- to\_array
- to\_dictionary
- to\_list
- to\_lookup
- where

# SEE ALSO

- LINQ - .NET 統合言語クエリ

    [http://msdn.microsoft.com/ja-jp/library/bb308959.aspx](http://msdn.microsoft.com/ja-jp/library/bb308959.aspx)

- linq.js - LINQ for JavaScript

    [http://linqjs.codeplex.com/](http://linqjs.codeplex.com/)

# LICENSE

Copyright (C) htk291

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

htk291 <htk291@gmail.com>

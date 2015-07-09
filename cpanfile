requires 'perl', '5.008001';
requires 'Exporter';
requires 'Params::Validate';
requires 'Scalar::Util';
requires 'List::Util';
requires 'List::MoreUtils';
requires 'Test::Deep::NoTest';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::Warn';
};


requires 'perl', '5.008001';
requires 'Exporter';
requires 'Params::Validate';
requires 'Scalar::Util';
requires 'List::Util';

on 'test' => sub {
    requires 'Test::More', '0.98';
};


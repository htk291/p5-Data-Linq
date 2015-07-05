requires 'perl', '5.008001';
requires 'Exporter::Lite';
requires 'Params::Validate';

on 'test' => sub {
    requires 'Test::More', '0.98';
};


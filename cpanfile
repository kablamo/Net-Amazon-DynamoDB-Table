requires 'perl', '5.008001';
requires 'Net::Amazon::DynamoDB::Lite', '0.03';

on 'test' => sub {
    requires 'Test::More', '0.98';
};


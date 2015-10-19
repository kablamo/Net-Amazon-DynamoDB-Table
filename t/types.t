use strict;
use warnings;
use Test::More;# skip_all => 'third party tests';
use Test::Deep;

use Net::Amazon::DynamoDB::Table;

my $table = Net::Amazon::DynamoDB::Table->new(
    region     => 'us-west-1',
    table      => 'test',
    hash_key   => 'super',
    access_key => $ENV{AWS_ACCESS_KEY},
    secret_key => $ENV{AWS_SECRET_KEY},
);

my $deflated = {
    a => 1,
    b => "pants",
    c => 23.5,
    e => { a => 23.5, b => "pants" },
    f => [ "pants", 23.5 ],
    g => "23",
};

my $inflated = {
    a => { N    => 1       },
    b => { S    => "pants" },
    c => { N    => 23.5    },
    e => { 
        M => { 
            a => { N => 23.5    },
            b => { S => "pants" }, 
        },
    },
    f => { 
        L => [ 
            { S => "pants" },
            { N => 23.5    },
        ],
    },
    g => { S => "23" },
};

my $out1 = $table->inflate_item($deflated);
cmp_deeply $out1, $inflated, "inflate()";

#my $out2 = $table->deflate($inflated);
#cmp_deeply $out2, $deflated, "deflate()";

done_testing;

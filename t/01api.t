use strict;
use Test::More tests => 8;
use Bot::Babelfish;

# check that the following functions are available
ok( defined \&Bot::Babelfish::init ); #01
ok( defined \&Bot::Babelfish::said ); #02

# create an object
my $bot = undef;
eval { $bot = new Bot::Babelfish };
is( $@, ''                         ); #03
ok( defined $bot                   ); #04
ok( $bot->isa('Bot::Babelfish')    ); #05
is( ref $bot, 'Bot::Babelfish'     ); #06
 
# check that the following object methods are available
ok( ref $bot->can('init')          ); #07
ok( ref $bot->can('said')          ); #08


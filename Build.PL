use strict;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Bot::Babelfish',
    license             => 'perl',
    dist_author         => 'Sébastien Aperghis-Tramoni <sebastien@aperghis.net>',
    dist_version_from   => 'lib/Bot/Babelfish.pm',
    requires => {
        'Bot::BasicBot' => '0.5',
        'Cache' => '2.0',
        'Carp' => '0',
        'WWW::Babelfish' => '0.12',
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Bot-Babelfish-*' ],
);

$builder->create_build_script();

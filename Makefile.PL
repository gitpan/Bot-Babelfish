use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Bot::Babelfish',
    AUTHOR              => 'Sébastien Aperghis-Tramoni <sebastien@aperghis.net>',
    VERSION_FROM        => 'lib/Bot/Babelfish.pm',
    ABSTRACT_FROM       => 'lib/Bot/Babelfish.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Bot::BasicBot' => '0.5',
        'Cache' => '2.0',
        'Carp' => '0',
        'WWW::Babelfish' => '0.12',
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Bot-Babelfish-*' },
);

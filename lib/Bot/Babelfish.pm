package Bot::Babelfish;
use strict;
use Bot::BasicBot;
use Cache::File;
use Carp;
use WWW::Babelfish;

{ no strict;
  $VERSION = '0.01';
  @ISA = qw(Bot::BasicBot);
}

=head1 NAME

Bot::Babelfish - Provides Babelfish translation services via an IRC bot

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use Bot::Babelfish;

    my $bot = Bot::Babel->new();
    ...

=head1 DESCRIPTION

XXX

=head1 METHODS

=over 4

=item init()

Initializes private data. 

=cut

sub init {
    my $self = shift;
    
    $self->{babel} = {
        service => undef, 
        cache   => undef, 
        langs   => {}, 
    };

    $self->{babel}{service} = new WWW::Babelfish service => 'Babelfish', 
        agent => "Bot-Babelfish/$Bot::Babelfish::VERSION"
      or croak "fatal: Can't create new WWW::Babelfish object" 
      and return undef;
    
    $self->{babel}{cache} = new Cache::File cache_root => '/tmp/babel'
      or croak "fatal: Can't create new Cache::File object" 
      and return undef;
    
    my $langpairs = $self->{babel}{service}->languagepairs;
    my %langs = ();
    for my $src (keys %$langpairs) {
        for my $dest (keys %{$langpairs->{$src}}) {
            $langs{ $langpairs->{$src}{$dest} } = [ $src, $dest ]
        }
    }
    $self->{babel}{langs} = { %langs };
    
    return 1
}

=item said()

Main function for interacting with the bot object. 
It follows the C<Bot::BasicBot> API and expect an hashref as argument. 

=cut

sub said {
    my $self = shift;
    my $args = shift;

    # don't do anything unless directly addressed
    return undef unless $args->{address} eq $self->nick or $args->{channel} eq 'msg';

    my $lang_src = 'English';
    my $lang_dest = 'French';

    $args->{body} =~ s/^ *(\w\w)[ 2>](\w\w): *// and 
      ($lang_src,$lang_dest) = @{ $self->{babel}{langs}{"${1}_$2"} };
    my $text = $args->{body};
    
    my $result = $self->{babel}{service}->translate(
        source => $lang_src, destination => $lang_dest, text => $text
    );
    
    $args->{body} = defined($result) ? 
      qq|$lang_dest for "$text" is "$result"| : 
      'error: '.$self->{babel}{service}->error;

    $self->say($args);
    
    return undef
}

=back

=head1 DIAGNOSTICS

=over 4

=item Can't create new %s object

B<(F)> Occurs in C<init()>. As the message says, we were unable to create 
a new object of the given class. 

=back

=head1 SEE ALSO

L<Bot::BasicBot>

=head1 AUTHOR

SE<eacute>bastien Aperghis-Tramoni, E<lt>sebastien@aperghis.netE<gt>

=head1 BUGS

Please report any bugs or feature requests to 
L<bug-bot-babel@rt.cpan.org>, or through the web interface at 
L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Bot-Babelfish>. 
I will be notified, and then you'll automatically be notified 
of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2005 SE<eacute>ébastien Aperghis-Tramoni, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Bot::Babelfish

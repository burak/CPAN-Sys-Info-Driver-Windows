package Sys::Info::Driver::Windows::OS::Net;
use strict;
use warnings;
use Win32;
use Sys::Info::Constants qw( WIN_USER_INFO_LEVEL );

our $VERSION = '0.70';

BEGIN {
    if ( ! Win32::IsWin95() ) {
        # Win32API::Net: 0.13  Thu Sep 17 19:35:20 1998
        # Some changes : 0.15  Sat Sep 25 15:53:02 1999
        # seems OK ot use.
        require Win32API::Net;
        Win32API::Net->import( qw() );
    }
}

sub _user_get_info {
    return +() if Win32::IsWin95();
    my $self   = shift;
    my $user   = shift || return;
    my $server = Sys::Info::Driver::Windows::OS->node_name();
    my %info;
    Win32API::Net::UserGetInfo( $server, $user, WIN_USER_INFO_LEVEL, \%info );
    return %info;
}

sub user_fullname {
    my $self = shift;
    my $user = shift || return;
    my %info = $self->_user_get_info( $user );
    return $info{fullName};
    # $info{comment}
}

sub user_logon_server {
    my $self = shift;
    my $user = shift || return;
    my %info = $self->_user_get_info( $user );
    return $info{logonServer};
    # $info{comment}
}

1;

__END__

=pod

=head1 NAME

Sys::Info::Driver::Windows::OS::Net - A minimal interface to Win32API::Net

=head1 SYNOPSIS

    use Sys::Info::Driver::Windows::OS::Net;
    print Sys::Info::Driver::Windows::OS::Net->user_fullname( $login );

=head1 DESCRIPTION

A minimal interface to Win32API::Net. If you're under Win9x, all methods
will return C<undef>.

=head1 METHODS

=head2 user_fullname USER

Return's the user's full (real) name if possible.

=head2 user_logon_server USER

Returns the logon server of C<USER> if possible.

=cut

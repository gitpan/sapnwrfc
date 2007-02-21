package SAPNW::Connection;

=pod

    Copyright (c) 2006 - 2007 Piers Harding.
        All rights reserved.

=cut

  use strict;
  require 5.008;
  require DynaLoader;
  require Exporter;
  use Data::Dumper;
  use SAPNW::Base;

	use base qw(SAPNW::Base);



  use vars qw(@ISA $VERSION $DEBUG $SAPNW_RFC_CONFIG);
  $VERSION = '0.02';
  @ISA = qw(DynaLoader Exporter); 

  sub dl_load_flags { $^O =~ /hpux|aix/ ? 0x00 : 0x01 }
  SAPNW::Connection->bootstrap($VERSION);

  sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my @rest = @_;
    my $self = {
       INTERFACES => {},
       CONFIG => { @rest },
       HANDLE => undef
    };
    #debug("Conecction Config is: ".Dumper($self->{CONFIG}));
    bless($self, $class);
    return $self;
	}


	sub config {
	  my $self = shift;
		return $self->{CONFIG};
	}


	sub interfaces {
	  my $self = shift;
		return $self->{INTERFACES};
	}


# Tidy up open Connection when DESTROY Destructor Called
sub DESTROY {
    my $self = shift;
    $self->disconnect() if exists $self->{HANDLE} && defined($self->{HANDLE});
}

1;

package SAPNW::RFC::Parameter;
=pod

    Copyright (c) 2006 - 2007 Piers Harding.
    All rights reserved.

=cut
use strict;

use SAPNW::Base;
use base qw(SAPNW::Base);
use Data::Dumper;

use vars qw($VERSION $AUTOLOAD);
$VERSION = '0.02';


  sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
		my ($name, $type, $len, $ulen, $decimals, $direction) = @_;
    my $self = {
       NAME => $name,
       TYPE => $type,
       LEN => $len,
       ULEN => $ulen,
       DECIMALS => $decimals,
       DIRECTION => $direction,
			 VALUE => undef,
    };
    bless($self, $class);
    return $self;
	}

  sub name { 
	  my $self = shift;
		return $self->{NAME};
	}

	sub value {
	  my $self = shift;
		$self->{VALUE} = shift if scalar @_;
		return $self->{VALUE};
	}

  sub type { 
	  my $self = shift;
		return $self->{TYPE};
	}

  sub len { 
	  my $self = shift;
		return $self->{LEN};
	}

  sub ulen { 
	  my $self = shift;
		return $self->{ULEN};
	}

  sub decimals { 
	  my $self = shift;
		return $self->{DECIMALS};
	}

  sub direction { 
	  my $self = shift;
		return $self->{DIRECTION};
	}


package SAPNW::RFC::Import;
use base qw(SAPNW::RFC::Parameter);
use SAPNW::Base;
  sub new {
	  my $class = shift;
	  my $self =  $class->SUPER::new(@_, RFCIMPORT);
		bless ($self, $class);
		return $self;
	}


package SAPNW::RFC::Export;
use base qw(SAPNW::RFC::Parameter);
use SAPNW::Base;
  sub new {
	  my $class = shift;
	  my $self =  $class->SUPER::new(@_, RFCEXPORT);
		bless ($self, $class);
		return $self;
	}


package SAPNW::RFC::Changing;
use base qw(SAPNW::RFC::Parameter);
use SAPNW::Base;
  sub new {
	  my $class = shift;
	  my $self =  $class->SUPER::new(@_, RFCCHANGING);
		bless ($self, $class);
		return $self;
	}


package SAPNW::RFC::Table;
use base qw(SAPNW::RFC::Parameter);
use SAPNW::Base;
  sub new {
	  my $class = shift;
	  my $self =  $class->SUPER::new(@_, RFCTABLES);
		bless ($self, $class);
		return $self;
	}


1;

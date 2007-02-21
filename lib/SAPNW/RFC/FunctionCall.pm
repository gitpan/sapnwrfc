package SAPNW::RFC::FunctionCall;
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


  sub AUTOLOAD {

    my $self = shift;
    my $type = ref($self)
            or die "$self is not an Object in autoload of Iface";
    my $name = $AUTOLOAD;
    $name =~ s/.*://;

#   Autoload parameters and tables
    if ( exists $self->{PARAMETERS}->{$name} ) {
       return $self->{PARAMETERS}->{$name}->value(@_);
    } else {
        die "Parameter $name does not exist in Interface - no autoload";
    };
  }

	sub DESTROY {
	  my $self = shift;
		return SAPNW::Connection::destroy_function_call($self);
	}


	sub name {
	  my $self = shift;
		return $self->{NAME};
	}


  sub initialise {
	  my $self = shift;
	  my $funcdesc = shift;
		$self->{PARAMETERS} = {};
		#debug("initialise: ".Dumper($self));
    foreach my $p (values %{$funcdesc->parameters}) {
      my $type = ref($p);
			no strict 'refs';
			# my ($funcdesc, $name, $type, $len, $ulen, $decimals, $direction) = @_;
			my $np = &{$type."::new"}($type, $p->name, $p->type, $p->len, $p->ulen, $p->decimals, $p->direction);
      $self->{PARAMETERS}->{$np->name} = $np;
		}
    return $self;
	}

	sub parameters {
	  my $self = shift;
		return $self->{PARAMETERS};
	}

	sub invoke {
	  my $self = shift;
		#return $self->{CONN}->invoke($self);
		return SAPNW::Connection::invoke($self);
  }


1;

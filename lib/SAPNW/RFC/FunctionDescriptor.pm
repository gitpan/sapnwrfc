package SAPNW::RFC::FunctionDescriptor;
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
    my @parms = @_;
    my $type = ref($self)
            or die "$self is not an Object in autoload of Iface";
    my $name = $AUTOLOAD;
    $name =~ s/.*://;

#   Autoload parameters and tables
    if ( exists $self->{PARAMETERS}->{$name} ) {
        return $self->{PARAMETERS}->{$name};
    } else {
        die "Parameter $name does not exist in Interface Descriptor - no autoload";
    };
  }


	sub DESTROY {
    my $self = shift;
		return SAPNW::Connection::destroy_function_descriptor($self);
	}

	sub name {
	  my $self = shift;
		return $self->{NAME};
	}


	# internal method used to add parameters from within the C extension
  sub addParameter {
	  my $self = shift;
    my ($name, $direction, $type, $len, $ulen, $decimals) = @_;
    #debug(__PACKAGE__.": parm: $name direction: $direction type: $type len: $len decimals: $decimals\n");
    my $p;
    if ($direction == RFCIMPORT) {
		  if (exists $self->{PARAMETERS}->{$name} && $self->{PARAMETERS}->{$name}->direction == RFCEXPORT) {
			  $p = new SAPNW::RFC::Changing($name, $type, $len, $ulen, $decimals);
			} else {
			  $p = new SAPNW::RFC::Import($name, $type, $len, $ulen, $decimals);
			}
	  } elsif ($direction == RFCEXPORT) {
		  if (exists $self->{PARAMETERS}->{$name} && $self->{PARAMETERS}->{$name}->direction == RFCIMPORT) {
			  $p = new SAPNW::RFC::Changing($name, $type, $len, $ulen, $decimals);
			} else {
			  $p = new SAPNW::RFC::Export($name, $type, $len, $ulen, $decimals);
			}
	  } elsif ($direction == RFCCHANGING) {
			  $p = new SAPNW::RFC::Changing($name, $type, $len, $ulen, $decimals);
	  } elsif ($direction == RFCTABLES) {
			  $p = new SAPNW::RFC::Table($name, $type, $len, $ulen, $decimals);
	  } else {
		  croak("unknown direction ($name): $direction\n");
	  }
    $self->{PARAMETERS}->{$p->name} = $p;
		#debug("parameter: ".Dumper($p));
		return $p;
  }


	sub parameters {
	  my $self = shift;
		return $self->{PARAMETERS};
	}

	sub create_function_call {
	  my $self = shift;
    #debug("create_function_call: ".Dumper($self));
		#return $self->{CONN}->create_function_call($self);
		return SAPNW::Connection::create_function_call($self);
	}


1;

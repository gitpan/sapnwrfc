package SAPNW::Base;

=pod

    Copyright (c) 2006 - 2007 Piers Harding.
        All rights reserved.

=cut

  use strict;
  require 5.008;
  use Data::Dumper;

  use vars qw($VERSION $DEBUG $SAPNW_RFC_CONFIG);
  $VERSION = '0.02';

  use constant RFCIMPORT     => 1;
  use constant RFCEXPORT     => 2;
  use constant RFCCHANGING   => 3;
  use constant RFCTABLES     => 7;

  use constant RFCTYPE_CHAR  => 0;
  use constant RFCTYPE_DATE  => 1;
  use constant RFCTYPE_BCD   => 2;
  use constant RFCTYPE_TIME  => 3;
  use constant RFCTYPE_BYTE  => 4;
  use constant RFCTYPE_TABLE => 5;
  use constant RFCTYPE_NUM   => 6;
  use constant RFCTYPE_FLOAT => 7;
  use constant RFCTYPE_INT   => 8;
  use constant RFCTYPE_INT2  => 9;
  use constant RFCTYPE_INT1  => 10;
  use constant RFCTYPE_NULL  => 14;
  use constant RFCTYPE_STRUCTURE  => 17;
  use constant RFCTYPE_DECF16  => 23;
  use constant RFCTYPE_DECF34  => 24;
  use constant RFCTYPE_XMLDATA => 28;
  use constant RFCTYPE_STRING  => 29;
  use constant RFCTYPE_XSTRING => 30;
  use constant RFCTYPE_EXCEPTION => 98;


  # Export useful tools
  my @export_ok = qw(
	 debug
   RFCIMPORT
   RFCEXPORT
   RFCCHANGING
   RFCTABLES
   RFCTYPE_CHAR
   RFCTYPE_DATE
   RFCTYPE_BCD
   RFCTYPE_TIME
   RFCTYPE_BYTE
   RFCTYPE_TABLE
   RFCTYPE_NUM
   RFCTYPE_FLOAT
   RFCTYPE_INT
   RFCTYPE_INT2
   RFCTYPE_INT1
   RFCTYPE_NULL
   RFCTYPE_STRUCTURE
   RFCTYPE_DECF16
   RFCTYPE_DECF34
   RFCTYPE_XMLDATA
   RFCTYPE_STRING
   RFCTYPE_XSTRING
   RFCTYPE_EXCEPTION
	);

  sub import {
    my ( $caller ) = caller;
    no strict 'refs';
    foreach my $sub ( @export_ok ){
      *{"${caller}::${sub}"} = \&{$sub};
    }
  }

  sub debug {
	  return unless $DEBUG;
		print STDERR scalar localtime() . " - ". caller(), ":> " , @_, "\n";
	}


1;

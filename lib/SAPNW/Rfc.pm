package SAPNW::Rfc;
=pod

    Copyright (c) 2006 - 2007 Piers Harding.
    All rights reserved.

=cut
use SAPNW::Base;
use base qw(SAPNW::Base);


=pod

    Copyright (c) 2006 - 2007 Piers Harding.
        All rights reserved.

=cut

use strict;

require 5.008;

use vars qw(@ISA $VERSION $SAPNW_RFC_CONFIG);
$VERSION = '0.02';
@ISA = qw(SAPNW::Base);

use YAML;
use Data::Dumper;

use constant SAP_YML => 'sap.yml';

sub load_config {
  my $self = shift;
  my $file =  scalar  @_ ? shift @_ : SAP_YML;
  if (-f $file) {
    # yaml
    open(YML, "<$file") || die "Cannot open RFC config: $file\n";
    my $data = join("", (<YML>));
    close(YML);
    eval { $SAPNW_RFC_CONFIG = YAML::Load($data); };
    if ($@) {
      die "Parsing YAML config file failed($file): $@\n";
    }
  } else {
    die "Cant find RFC config to load in file: $file\n";
  }
  if (exists $SAPNW_RFC_CONFIG->{debug}) {
    $SAPNW::Base::DEBUG = $SAPNW_RFC_CONFIG->{debug};
  }
}


# Construct a new SAP::Rfc Object.
sub rfc_connect {
  my @keys = ();
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my @rest = @_;
  
  my $config = { map { $_ => $SAPNW_RFC_CONFIG->{$_} } keys %$SAPNW_RFC_CONFIG, @rest };
	my $conn = new SAPNW::Connection(%{$config});

  $conn->connect();
  return $conn;
}


1;

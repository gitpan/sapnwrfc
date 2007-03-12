#!/usr/bin/perl
use strict;
use lib '../blib/lib';
use lib '../blib/arch';
use lib './blib/lib';
use lib './blib/arch';
use sapnwrfc;
use Data::Dumper;

use vars qw($DEBUG);


#   Register an external program to provide outbound
#   RFCs

print "Testing SAPNW::Rfc-$SAPNW::Rfc::VERSION\n";
SAPNW::Rfc->load_config;

my $func = new SAPNW::RFC::FunctionDescriptor("RFC_REMOTE_PIPE");
my $pipedata = new SAPNW::RFC::Type(name => 'DATA', 
			                              type => RFCTYPE_TABLE,
																		fields => [{name => 'LINE',
																			          type => RFCTYPE_CHAR, 
																			          len => 80}
																									]
																			);
$func->addParameter(new SAPNW::RFC::Export(name => "COMMAND", len => 80, type => RFCTYPE_CHAR));
$func->addParameter(new SAPNW::RFC::Table(name => "PIPEDATA", len => 80, type => $pipedata));
$func->callback(\&do_remote_pipe);

my $pass = 0;
my $server = SAPNW::Rfc->rfc_register(
                           tpname   => 'wibble.rfcexec',
                           gwhost   => 'ubuntu.local.net',
                           gwserv   => '3301',
                           trace    => '1' );

print STDERR "Connection attributes: ".Dumper($server->connection_attributes)."\n";

$server->installFunction($func);

print STDERR " START: ".scalar localtime() ."\n";

$server->accept(5, \&do_something);



sub do_something {
  my $thing = shift;
  debug("Running do_something ($thing) ...");
	return 1;
}


sub do_remote_pipe {
  my $func = shift;
  debug("Running do_remote_pipe...");
  my $ls = $func->COMMAND;
  $func->PIPEDATA( [ map {  { 'LINE' => pack("A80",$_) } } split(/\n/, `$ls`) ]);
  #die "MY_CUSTOM_ERROR with some other text";
	$pass += 1;
	if ($pass >= 750) {
    return undef;
	} else {
    return 1;
	}
}


sub debug {
  return unless $DEBUG;
  print  STDERR scalar localtime().": ", @_, "\n";
}


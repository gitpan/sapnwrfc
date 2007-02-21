use Test::More;
use constant ITER => 50;

plan tests => (ITER * 4);
BEGIN { use_ok("sapnwrfc"); };

print "Testing SAPNW::Rfc-$SAPNW::Rfc::VERSION\n";
SAPNW::Rfc->load_config;


foreach (1..ITER) {
  my $conn = SAPNW::Rfc->rfc_connect;
  my $attrib = $conn->connection_attributes;
	ok($attrib);
  ok($attrib->{pcs} =~ /^(1|2)$/);
  ok($attrib->{rfcRole} eq 'C');
  ok($conn->disconnect);
}


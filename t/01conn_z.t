use Test::More tests => 101;

use_ok("sapnwrfc");

print STDERR  "Testing SAPNW::Rfc-$SAPNW::Rfc::VERSION\n";
SAPNW::Rfc->load_config;

foreach (1..50) {
  my $conn = SAPNW::Rfc->rfc_connect;
	ok($conn);
  ok($conn->disconnect);
}


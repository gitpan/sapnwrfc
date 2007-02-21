use Test::More;
use constant ITER => 50;

plan tests => (ITER * 2);
BEGIN { use_ok("sapnwrfc"); };

print STDERR  "Testing SAPNW::Rfc-$SAPNW::Rfc::VERSION\n";
SAPNW::Rfc->load_config;

foreach (1..ITER) {
  my $conn = SAPNW::Rfc->rfc_connect;
	ok($conn);
  ok($conn->disconnect);
}


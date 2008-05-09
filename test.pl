# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use Net::IPv6Address;;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

use Debug;

my $debug = new Debug();
$debug->debugFile("debug.log");
$debug->initialize();
$debug->detail(1);
$debug->timeStamp(1);
$debug->initialize();
my $address = "3ffe:0:234:f56::1";
my $length = 60;
my $ipv6address = new Net::IPv6Address($address);
$ipv6address->loadDebug($debug);
$ipv6address->decompressAddress();
# print "Returned address = $buf\n";
# print "address = $address\n";
$debug->message($ipv6address->formatAddress());
$ipv6address->hexToBin();
$ipv6address->binToHex();
$debug->message("address ".$ipv6address->address().", length = ".$ipv6address->addressLength());

my $bin = $ipv6address->hexToBin();
my $binlen = length($bin);
my $diff = $binlen - $length;
$debug->message("diff = $diff");
my $left = substr $bin, 0, $diff;
my $right = substr $bin, ($diff), $binlen;

$debug->message("left = $left");
$debug->message("right = $right");
$debug->message("all = $bin");

my $test .= $left;
$test .= $right;

my $foo = length($test);
my $bar = length($bin);
$debug->message("$test($foo)");
$debug->message("$bin($bar)");
if($test eq $bin) {
	$debug->message("equal");
} else {
	$debug->message("not equal");
}

my $v6addr = new Net::IPv6Address();
$v6addr->address("2001:0558:ff10:0800:0::1");
$debug->message("Prefix = ".$v6addr->prefix());
$debug->message("Interface = ".$v6addr->interface());

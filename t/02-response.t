use v6.c;

use Amazon::AWS::TestUtils;

sub MAIN (:$unit, :$number = 1, :$elems = 1) {
  doBasicTests(
    getTestFiles('Response::', :$unit),
    :$number,
    :$elems
  );
}

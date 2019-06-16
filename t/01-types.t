use v6.d;

use Amazon::AWS::TestUtils;

sub MAIN (:$unit, :$elems = 5, :$number = 1) {
  doBasicTests(
    getTestFiles('Types::', :$unit),
    :$number,
    :$elems,
  );
}

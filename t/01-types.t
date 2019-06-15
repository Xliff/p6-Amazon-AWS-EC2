use v6.d;

use Amazon::AWS::TestUtils;

sub MAIN (:$unit, :$number = 1) {
  doBasicTests(
    getTestFiles('Types::', :$unit),
    :$number
  );
}

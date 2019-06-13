use v6.d;

use Amazon::AWS::TestUtils;

sub MAIN (:$unit) {
  doBasicTests( getTestFiles('Types::', :$unit) );
}

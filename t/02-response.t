use v6.c;

use Amazon::AWS::TestUtils;

sub MAIN (:$unit) {
  doBasicTests( getTestFiles('Response::', :$unit) );
}

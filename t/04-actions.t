use v6.c;

use Test;

use Amazon::AWS::TestUtils;

sub MAIN (:$unit, :$number = 1, :$private) {
  my @files = getTestFiles('Action::', :$unit);

  my %prefixes = (
    moreTests => 'lib/Amazon/AWS/EC2/AdditionalTests',
    privTests => 'lib/Amazon/AWS/EC2/PrivateTests'
  );
  # So that privTests can live OUTSIDE the main repo.
  %prefixes<privTests> = $private if $private.defined;

  plan 3 * +@files * $number;

  for ^$number {
    for @files {
      subtest "{ .IO.basename } basic tests" => {
        doBasicTests( getTestFiles('Action::', :$unit) );
      }

      for %prefixes.kv -> $pk, $pv {
        if "{ $pv }/{ $basename }".IO.e {
          my $testPackage := (try require ::("{ $pv }/{ $basename }"));
          die "Could not load 'Tests/{ $testPackage }'!"
            unless $testPackage !~~ Failure;
          my $testClassName = "Amazon::AWS::EC2::Tests/{
            S/'.pm'6? $// given $testPackage;
          }";
          die "Could not instantiate a { $testClassName } object"
            unless (my $testClass := ::($testClassName).new);

          subtest "[{ $pk }] $testPackage specific testing" => sub {
            # Static classes!
            $testClass.runTests;
          }
        } else {
          ok True, "[{ $pk }] No $testPackage specific tests found";
        }
      }
    }
  }
}

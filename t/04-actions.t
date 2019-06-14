use v6.c;

use Test;

use Amazon::AWS::TestUtils;

constant testsLocationPrefix = 'lib/Amazon/AWS/EC2/Tests';

sub MAIN (:$unit) {
  my @files = getTestFiles('Action::', :$unit);

  plan 2 * +@files;

  for @files {
    subtest "{ .IO.basename } basic tests" => {
      doBasicTests( getTestFiles('Action::', :$unit) );
    }

    if (my $testPackage = .IO.parts<basename>).IO.e {
      my $testPackage := (try require ::("{ testsLocationPrefix }/{ $testPackage }"));
      die "Could not load 'Tests/{ $testPackage }'!"
        unless $testPackage !~~ Failure;
      my $testClassName = "Amazon::AWS::EC2::Tests/{
        S/'.pm'6? $// given $testPackage;
      }";
      die "Could not instantiate a { $testClassName } object"
        unless (my $testClass := ::($testClassName).new);

      subtest "$testPackage specific testing" => sub {
        # Static classes!
        $testClass.runTests;
      }
    } else {
      ok True, "No $testPackage specific tests found";
    }
  }
}

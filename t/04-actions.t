use v6.c;

use Test;

use Amazon::AWS::TestUtils;

sub MAIN (:$unit, :$number = 1, :$private) {
  my @files = getTestFiles('Action::', :$unit);

  my %prefixes = (
    moreTests => 'Amazon::AWS::EC2::AdditionalTests',
    privTests => 'Amazon::AWS::EC2::PrivateTests'
  );
  # So that privTests can live OUTSIDE the main repo.
  %prefixes<privTests> = $private if $private.defined;

  plan 3 * +@files * $number;

  for ^$number {
    for @files {
      my $basename = .IO.basename;
      subtest "{ $basename } basic tests" => {
        doBasicTests(
          $_.Array,
          :$number
        );
      }

      for %prefixes.kv -> $pk, $pv {
        if "{ $pv }/{ $basename }".IO.e {
          my $testClassName = "{ $pv }::{ $basename }";
          my $testPackage := ( try require ::($testClassName) );
          die "Could not load '{ $testClassName }'!"
            unless $testPackage !~~ Failure;
          die "Could not instantiate a { $testClassName } object"
            unless (my $testClass := ::($testClassName).new);

          subtest "[{ $pk }] $basename specific testing" => sub {
            # Static classes!
            $testClass.runTests;
          }
        } else {
          ok True, "[{ $pk }] No $basename specific tests found";
        }
      }
    }
  }
}

use v6.c;

use Test;

use Amazon::AWS::TestUtils;

sub MAIN (:$unit, :$number = 1, :$private, :$tests is copy) {
  my @files = getTestFiles('Action::', :$unit);

  my %prefixes = (
    more => 'Amazon::AWS::EC2::AdditionalTests',
    private => 'Amazon::AWS::EC2::PrivateTests'
  );
  my @valid-tests = |%prefixes.keys, |<all basic>;
  @valid-tests.say;

  $tests //= 'all';
  my @tests = $tests.split(',');
  die qq:to/DIE/.chomp unless @tests.all ~~ @valid-tests.any;
    Tests must be a string, or comma separater list containing the following values:
      basic, { @valid-tests.join(', ') } or all
    DIE

  # So that privTests can live OUTSIDE the main repo.
  %prefixes<privTests> = $private if $private.defined;

  plan 3 * +@files * $number;

  for ^$number {
    for @files {
      my $basename = .IO.basename;
      subtest "{ $basename } basic tests" => {
        doBasicTests( .Array ) if <basic all>.any ∈ @tests;
      }

      for %prefixes.kv -> $pk, $pv {
        next unless ($pk, 'all').any ∈ @tests;
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

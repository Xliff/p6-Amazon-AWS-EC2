use v6.c;

use Test;

use Amazon::AWS::TestUtils;

sub MAIN (:$unit, :$number = 1, :$elems = 5, :$private, :$tests is copy) {  
  # Figure out a more robust way to invoke this.
  qqx{scripts/dependencies.pl6};
  
  my @files = getTestFiles('Action::', :$unit);

  my %prefixes = (
    more => 'Amazon::AWS::EC2::Tests',
    private => 'Amazon::AWS::EC2::Tests::Private'
  );
  my @valid-tests = |%prefixes.keys, |<basic all>;

  $tests //= 'all';
  my @tests = $tests.split(',');
  die qq:to/DIE/.chomp unless @tests.all ~~ @valid-tests.any;
    Tests must be a string, or comma separater list containing the following values:
      { @valid-tests.sort.grep(* ne 'all').join(', ') } or all
    DIE

  # So that privTests can live OUTSIDE the main repo.
  %prefixes<privTests> = $private if $private.defined;
    
  plan 3 * +@files * $number;

  # Should be a better way to abstract the timing code out... Think about it.
  my ($elev, $timeStart) = (0, DateTime.now);
  my %timings;
  my $iteration;
  
  for ^$number {
    # If you really want speed, this needs to be in nqp!
    if $do-timings && $iteration++ > (my $exp = 10 ** $elev) {
      %timings{$exp} = DateTime.now - $timeStart;
      $timeStart = DateTime.now;
      $elev++;
    }
    
    for @files -> $f {
      my $baseName = $f.split('::')[* - 1];
      subtest "{ $baseName } basic tests" => sub {
        plan :skip-all<Skipping Basic tests> unless <basic all>.any ∈ @tests;
        doBasicTests( $f.Array, :$elems, :!do-timings ) 
      }

      for %prefixes.kv -> $pk, $pv {
        # Must replace "Action" with type of test, but that is for the 
        # FILE EXISTANCE CHECK. What we really want to do is load the 
        # test module if it exists, and that could just be a 
        # DYNAMIC LOAD! Doing both is the proper way, but we could probably
        # just do the latter.
        
        # To do FILE EXISTANCE CHECK, we FIRST must change $pv to the proper 
        # directory.
        my $file = "lib/{ S:g['::'] = '/' given $pv }/{ $baseName }.pm6";
        if $file.IO.e {
          my $testPackageName = "{ $pv }::{ $baseName }";
          my $testPackage := ( try require ::($testPackageName) );

          subtest "[{ $pk }] $baseName specific testing" => sub {
            plan :skip-all("Skipping { $pk } tests") 
              unless ($pk, 'all').any ∈ @tests;
            ::("\&{$testPackageName}::runTests")();
          }
        } else {
          ok True, "[{ $pk }] No $baseName specific tests found";
        }
      }
    }
  }
  if $do-timings {
    %timings{$iteration} = DateTime.now - $timeStart;
    diag %timings.gist;
    diag "Total time: { %timings.values.sum }s";
  }
}

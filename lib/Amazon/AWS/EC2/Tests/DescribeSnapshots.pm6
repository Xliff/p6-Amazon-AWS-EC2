use v6.d;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeSnapshots;

our sub runTests {
  my $c = $?FILE.split('::')[*-1].substr(0, * - 1);
  # YYY- Determine why quietly is needed, here!
  my ($action, $response);
  quietly {
    ( %classes{$c} := 
      try require ::("Amazon::AWS::EC2::Action::{ $c }") )
        if not %classes{$c}:exists;
    ( %classes{"{$c}Response"} := 
      try require ::("Amazon::AWS::EC2::Response::{ $c }Response") )
        if not %classes{"{$c}Response"}:exists;
  }
  
  runActionResponseTests(
    %classes{$c}, 
    %classes{"{$c}Response"},
    -> $o { $o.Owners = ('self') }
  );
}
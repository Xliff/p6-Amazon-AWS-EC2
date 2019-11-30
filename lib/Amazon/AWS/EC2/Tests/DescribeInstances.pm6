use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeInstances;

our sub runTests {
  my $c = $?FILE.split('::')[* - 1].substr(0, * - 1);
  # YYY- Determine why quietly is needed, here!
  my ($action, $response);
  quietly {
    $response := do {
      if not %classes{"{ $c }Response"}:exists {
        %classes{"{ $c }Response"} :=
          try require ::("Amazon::AWS::EC2::Response::{ $c }Response");
      }
      %classes{"{ $c }Response"};
    };

    $action := do {
      if not %classes{$c}:exists {
        %classes{$c} := try require ::("Amazon::AWS::EC2::Action::{ $c }");
      }
      %classes{$c}
    };
  }

  runActionResponseTests($action, $response);
}

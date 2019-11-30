use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeImageAttribute;

my @imageIds;

our sub runTests {
  my $c = $?FILE.split('::')[*-1].substr(0, * - 1);
  # YYY- Determine why quietly is needed, here!
  my ($action, $response);
  quietly {
    $action := do {
      if not %classes{$c}:exists {
        %classes{$c} := try require ::("Amazon::AWS::EC2::Action::{ $c }");
      }
      %classes{$c}
    };
    $response := do {
      if not %classes{"{$c}Response"}:exists {
        %classes{"{$c}Response"} :=
          try require ::("Amazon::AWS::EC2::Response::{ $c }Response");
      }
      %classes{"{$c}Response"};
    };

    # Load extra classes LAST!
    %classes<DescribeImages> = try require ::('Amazon::AWS::EC2::Action::DescribeImages');
  }

  subtest 'Testing with all attributes' => sub {
    # An OLD bug prevents blockDeviceMapping attribute from being queried. See:
    # https://forums.aws.amazon.com/thread.jspa?threadID=79821
    my @attributes = $action.getAttributes.grep( * ne 'blockDeviceMapping' );

    # Get random image attribute from images.
    # Should have some mechanism where we can get maxResults passed in
    # from the command line using the naked value as a default.
    unless @imageIds {
      @imageIds = %classes<DescribeImages>.new(maxResults => 50)
                                          .run
                                          .images
                                          .map( *.imageId )
    }
    my $imageId = @imageIds.pick;

    diag "Using imageID: { $imageId }";
    plan @attributes.elems * actionResponseTests;
    for @attributes {
      my $fixup = -> $o {
        $o.ImageId = $imageId;
        $o.Attribute = $_;
      };
      runActionResponseTests(
        $action,
        $response,
        $fixup,
        :!plan
      );
    }
  }
}

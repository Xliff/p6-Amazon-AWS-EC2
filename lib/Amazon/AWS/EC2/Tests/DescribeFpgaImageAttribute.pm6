use v6.d;

use Test;

use Amazon::AWS::EC2::Action::DescribeFpgaImages;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeFpgaImageAttribute;

my @fpgaImageIds;

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
  }
  
  subtest 'Testing with all attributes' => sub {
    my @attributeNames = $action.getImageAttributes;
    
    # Get random image attribute from images.
    # Should have some mechanism where we can get maxResults passed in
    # from the command line using the naked value as a default.
    unless @fpgaImageIds {
      @fpgaImageIds = DescribeFpgaImages.new(maxResults => 50)
                                        .run
                                        .fpgaImages
                                        .map( *.fpgaImageId ) 
    }
    my $imageId = @fpgaImageIds.pick;
                                        
    diag "Using imageID: { $imageId }"; 
    plan @attributeNames.elems * actionResponseTests;
    for @attributeNames {
      my $fixup = -> $o { 
        $o.FpgaImageId = $imageId;
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

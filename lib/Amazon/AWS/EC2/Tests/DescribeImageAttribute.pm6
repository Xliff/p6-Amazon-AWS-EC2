use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeImageAttribute;

my @imageIds;

our sub runTests {

  subtest 'Testing with all attributes' => sub {
    my @attributes = $action.getAttributes;
    
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
      runTestCore(
        $?PACKAGE,
        loader => -> {
          # Load extra classes LAST!
          %classes<DescribeImages> = 
            try require ::('Amazon::AWS::EC2::Action::DescribeImages');
        }
        fixup => -> $o { 
          $o.ImageId = $imageId;
          $o.Attribute = $_;
        },
        :!plan
      );
    }
  }
}

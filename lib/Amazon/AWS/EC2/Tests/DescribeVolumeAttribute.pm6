use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeVolumeAttribute;

my @volumeIds;

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
    %classes<DescribeVolumes> = 
      try require ::('Amazon::AWS::EC2::Action::DescribeVolumes');
  }
  
  subtest 'Testing with all attributes' => sub {
    my @attributes = $action.getAttributes;
    
    # Get random image attribute from images.
    # Should have some mechanism where we can get maxResults passed in
    # from the command line using the naked value as a default.
    unless @volumeIds {
      @volumeIds = %classes<DescribeVolumes>.new(maxResults => 50 )
                                            .run
                                            .volumes
                                            .map( *.volumeId ) 
    }
    my $volumeId = @volumeIds.pick;
                                        
    diag "Using VolumeID: { $volumeId }"; 
    plan @attributes.elems * actionResponseTests;
    for @attributes {
      my $fixup = -> $o { 
        $o.VolumeId = $volumeId;
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

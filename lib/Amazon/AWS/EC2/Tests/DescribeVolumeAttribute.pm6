use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeVolumeAttribute;

my @volumeIds;

our sub runTests {

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
      runTestCore(
        $?PACKAGE,
        fixup => -> $o { 
          $o.VolumeId = $volumeId;
          $o.Attribute = $_;
        },
        loader => -> {
          # Load extra classes LAST!
          %classes<DescribeVolumes> = 
            try require ::('Amazon::AWS::EC2::Action::DescribeVolumes');
        },
        :!plan
      );
    }
  }
  
}

use v6.d;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Response::DescribePrincipalIdFormatResponse;
use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Action::DescribePrincipalIdFormat is export
  does XML::Class[
    xml-element   => 'DescribePrincipalIdFormat',
    xml-namespace => "http://ec2.amazonaws.com/doc/2016-11-15/"
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool $.DryRun     is xml-element                                                          is rw;
  has Int  $.MaxResults is xml-element                                                          is rw;
  has Str  @.Resources  is xml-element('item') is xml-container('resourcesSet') is xml-skip-null is rw;  #= bundle | conversion-task | customer-gateway | dhcp-options | elastic-ip-allocation | elastic-ip-association | export-task | flow-log | image | import-task | instance | internet-gateway | network-acl | network-acl-association | network-interface | network-interface-attachment | prefix-list | reservation | route-table | route-table-association | security-group | snapshot | subnet | subnet-cidr-block-association | volume | vpc | vpc-cidr-block association | vpc-endpoint | vpc-peering-connection | vpn-connection | vpn-gateway

  submethod BUILD (
    :$dryRun,
    :$maxResults,
    :@resources,
    # Testing purposes ONLY!
    :$!DryRun     = False,
    :$!MaxResults = 1000,
    :@!Resources
  ) {
    if $maxResults.defined {
      die '\$maxResults should be an integer from 1 to 1000'
        unless $maxResults ~~ 1..1000;
    }
      
    my $dieMsg = qq:to/DIE/.chomp;
      Invalid Resource value. Resource should be an array of the following values:
      { %attributes<Resources|Table> }
      DIE

    $!DryRun       = $dryRun     if $dryRun.defined;
    $!MaxResults   = $maxResults if $maxResults.defined;
    @!Resources    = @resources  if @resources;
        
    if @!Resources {
      @!Resources .= map({
        when %attributes<Resources|ValidValues>.Array.any  { $_ }
        default                                            { die $dieMsg }
      });
    }
  }

  method run (:$raw = False)
    is also<
      do
      execute
    >
  {
    my @ResourceArgs;
    my $cnt = 1;
    @ResourceArgs.push: Pair.new("Resource.{$cnt++}", $_) for @!Resources;
    
    # Should already be sorted.
    my @args = (
      DryRun     => $.DryRun,
      |@ResourceArgs,
      MaxResults => $!MaxResults,
      Version    => '2016-11-15'
    );

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }
  
  method getResources {
    %attributes<Resources|ValidValues>.Array;
  }

}

# For direct access to any Attribute metadata.
BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::DescribePrincipalIdFormat
  )
}

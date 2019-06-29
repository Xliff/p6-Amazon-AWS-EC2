use v6.d;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Response::DescribeIdentityIdFormatResponse;
use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Action::DescribeIdentityIdFormat is export
  does XML::Class[
    xml-element   => 'DescribeIdentityIdFormat',
    xml-namespace => "http://ec2.amazonaws.com/doc/2016-11-15/"
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str $.PrincipleArn is xml-element is xml-skip-null is rw;
  has Str $.Resource     is xml-element is xml-skip-null is rw;  #= bundle | conversion-task | customer-gateway | dhcp-options | elastic-ip-allocation | elastic-ip-association | export-task | flow-log | image | import-task | instance | internet-gateway | network-acl | network-acl-association | network-interface | network-interface-attachment | prefix-list | reservation | route-table | route-table-association | security-group | snapshot | subnet | subnet-cidr-block-association | volume | vpc | vpc-cidr-block-association | vpc-endpoint | vpc-peering-connection | vpn-connection | vpn-gateway
  
  submethod BUILD (
    Str :$principleArn,
    Str :$resource,
    # Testing purposes ONLY!
    Str :$!PrincipleArn,
    Str :$!Resource
  ) {
    my $dieMsg = qq:to/DIE/.chomp;
      Invalid Resource value. Resource value should be any of:
      { %attributes<Resource|Table> }
      DIE

    $!PrincipleArn = $principleArn if $principleArn.defined;
    $!Resource     = $resource     if $resource.defined;
    
    die $dieMsg unless $!Resource.defined.not ||
                       $!Resource ~~ %attributes<Resource|ValidValues>.any;
  }

  method run (:$raw = False)
    is also<
      do
      execute
    >
  {
    # Should already be sorted.
    my @args = (
      PrincipleArn => $.PrincipleArn,  
    );
    @args.unshift: Pair.new('Resource', $.Resource) if $.Resource.defined;
    @args.unshift: Pair.new('Version', '2016-11-15');

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
    %attributes<Resource|ValidValues>.Array;
  }

}

# For direct access to any Attribute metadata.
BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::DescribeIdentityIdFormat
  )
}

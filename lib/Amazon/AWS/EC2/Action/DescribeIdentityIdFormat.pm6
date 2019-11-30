use v6.d;

use Method::Also;
use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::DescribeIdentityIdFormatResponse;

my %attributes;

class Amazon::AWS::EC2::Action::DescribeIdentityIdFormat is export
  does XML::Class[
    xml-element   => 'DescribeIdentityIdFormat',
    xml-namespace => "http://ec2.amazonaws.com/doc/2016-11-15/"
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str $.PrincipalArn is xml-element is xml-skip-null is rw;
  has Str $.Resource     is xml-element is xml-skip-null is rw;  #= bundle | conversion-task | customer-gateway | dhcp-options | elastic-ip-allocation | elastic-ip-association | export-task | flow-log | image | import-task | instance | internet-gateway | network-acl | network-acl-association | network-interface | network-interface-attachment | prefix-list | reservation | route-table | route-table-association | security-group | snapshot | subnet | subnet-cidr-block-association | volume | vpc | vpc-cidr-block-association | vpc-endpoint | vpc-peering-connection | vpn-connection | vpn-gateway
  
  submethod BUILD (
    Str :$principalArn,
    Str :$resource,
    # Testing purposes ONLY!
    Str :$!PrincipalArn is copy = '',
    Str :$!Resource     is copy = ''
  ) {    
    $!PrincipalArn = $principalArn.trim
      if $principalArn.defined && $principalArn.trimchars;
    $!Resource = $resource.trim
      if $resource.defined && $resource.trim.chars;
      
    my $dieMsg = qq:to/DIE/.chomp;
      Invalid Resource value of '{ $!Resource }'. Resource value should be any of:
      { %attributes<Resource|Table> }
      DIE
    
    die $dieMsg unless $!Resource.chars.not ||
                       $!Resource ~~ %attributes<Resource|ValidValues>.any;
  }

  method run (:$raw = False)
    is also<
      do
      execute
    >
  {
    die 'PrincipalArn is required' unless $!PrincipalArn.chars;
    
    # Should already be sorted.
    my @args;
    @args.unshift: (Resource => $!Resource) if $!Resource.chars;
    @args.append: (
      PrincipalArn => urlEncode($!PrincipalArn),
      Version      => '2016-11-15'
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
  
  method getValidResources {
    %attributes<Resource|ValidValues>.Array;
  }

}

# For direct access to any Attribute metadata.
BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::DescribeIdentityIdFormat
  )
}

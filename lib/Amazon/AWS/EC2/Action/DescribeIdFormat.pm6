use v6.d;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Response::DescribeIdFormatResponse;
use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Action::DescribeIdFormat is export
  does XML::Class[
    xml-element   => 'DescribeIdFormat',
    xml-namespace => "http://ec2.amazonaws.com/doc/2016-11-15/"
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str $.Resource is xml-element is rw; #= bundle | conversion-task | customer-gateway | dhcp-options | elastic-ip-allocation | elastic-ip-association | export-task | flow-log | image | import-task | instance | internet-gateway | network-acl | network-acl-association | network-interface | network-interface-attachment | prefix-list | reservation | route-table | route-table-association | security-group | snapshot | subnet | subnet-cidr-block-association | volume | vpc | vpc-cidr-block association | vpc-endpoint | vpc-peering-connection | vpn-connection | vpn-gateway

  submethod BUILD (
    Str :$Resource,
  ) {
    die qq:to/DIE/.chomp unless $Resource.defined.not || $Resource ~~ %attributes<Resource|ValidValues>.any;
Invalid Resource value. Resource value should be any of:
{ %attributes<Resource|Table> }
DIE
    $!Resource = $Resource

  }

  method run (:$raw = False)
    is also<
      do
      execute
    >
  {
    # Should already be sorted.
    my @args = (
      Version  => '2016-11-15'
    );
    @args.unshift: Pair.new('Resource', $.Resource) if $.Resource.defined;

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      Amazon::AWS::EC2::Response::DescribeIdFormatResponse.from-xml($xml);
  }

}

# For direct access to any Attribute metadata.
BEGIN {
  %attributes = Amazon::AWS::EC2::Action::DescribeIdFormat.^attributes.map({
    .name.substr(2) => $_
  }).Hash;
  %attributes<Resource>.WHY ~~ /('?')? \s* (<[\w\-]>+)+ %% [ \s* '|' \s* ]/;
  %attributes<Resource|ValidValues> = (do gather for $/[1].Array {
    take .Str
  }).flat.Array;
  %attributes<Resource|MaxLength> = %attributes<Resource|ValidValues>.map(
    *.chars
  ).max;
  %attributes<Resource|Table> = (do
    gather for %attributes<Resource|ValidValues>.batch(3) {
      take "\t" ~
         .Array.fmt("%-{ %attributes<Resource|MaxLength> + 4 }s").join('')
    }
  ).join("\n");
}

use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::EC2::Response::DescribeVpcAttributeResponse;
use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

my %attributes;

class Amazon::AWS::EC2::Action::DescribeVpcAttribute is export
  does XML::Class[
    xml-element   => 'DescribeVpcAttribute',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str  $.Attribute is xml-element is xml-skip-null is rw;  #=  enableDnsSupport | enableDnsHostnames
  has Bool $.DryRun    is xml-element is xml-skip-null is rw;
  has Str  $.VpcId     is xml-element is xml-skip-null is rw;

  submethod BUILD (
    :$attribute,
    :$dryRun,
    :$vpcId,
    # For serialization purposes, ONLY!
    :$!Attribute = '',
    :$!DryRun = False,
    :$!VpcId = '',
  ) {
    $!DryRun    = $dryRun    if $dryRun.defined;
    $!Attribute = $attribute if $attribute.defined;
    $!VpcId     = $vpcId     if $vpcId.defined;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die '$VpcId is required!'     unless $!VpcId.chars;
    die '$Attribute is required!' unless $!Attribute.chars;

    die "Invalid value given for \$Attribute ('$!Attribute'). Must be one of:\n{
      %attributes<Attribute|Table>
    }" unless $!Attribute eq self.getValidAttributes.any;

    my @args.append: (
      Attribute     => $.Attribute,
      DryRun        => $.DryRun,
      Version       => '2016-11-15',
      VpcId         => $.VpcId
    );

   # XXX - Add error handling to makeRequest!
   my $xml = makeRequest(
     "?Action={$c}&{ @args.map({ "{.key}={.value}" }).join('&') }"
   );

   $raw ??
     $xml
     !!
     ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }

  method getValidAttributes {
    %attributes<Attribute|ValidValues>.Array;
  }

};

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::DescribeVpcAttribute
  );
}

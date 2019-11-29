use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::EC2::Response::DescribeFpgaImageAttributeResponse;
use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Action::DescribeFpgaImageAttribute is export
  does XML::Class[
    xml-element   => 'DescribeFpgaImageAttribute',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str  $.Attribute    is xml-element   is xml-skip-null is rw;  #= description | name | loadPermission | productCodes
  has Bool $.DryRun       is xml-element   is xml-skip-null is rw;
  has Str  $.FpgaImageId  is xml-element   is xml-skip-null is rw;

  submethod BUILD (
    :$attribute,
    :$dryRun,
    :$fpgaImageId,
    # For deserialization purposes, only!
    :$!Attribute    = '',
    :$!DryRun       = False,
    :$!FpgaImageId  = ''

  ) {
    # Abstract away into a sub done by Actions role?
    my $dieMsg = qq:to/DIE/.chomp;
      Invalid Attribute value. Valid value should be any of:
      { %attributes<Attribute|Table> }
      DIE

    $!DryRun      = $dryRun      if $dryRun.defined;
    $!Attribute   = $attribute   if $attribute.defined;
    $!FpgaImageId = $fpgaImageId if $fpgaImageId.defined;

    die $dieMsg
      unless
        $!Attribute.chars.not ||
        $!Attribute ~~ %attributes<Attribute|ValidValues>.any;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die '$!Attribute is required!'   unless $.Attribute.defined;
    die '$!FpgaImageId is required!' unless $.FpgaImageId.defined;

    # Keep things sorted.
    my @args;

    @args.append: (
      FpgaImageId   => $.FpgaImageId,
      Attribute     => $.Attribute,
      #DryRun        => $.DryRun,
      Version       => '2016-11-15'
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

  method getImageAttributes {
    %attributes<Attribute|ValidValues>.Array
  }

}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::DescribeFpgaImageAttribute
  )
}

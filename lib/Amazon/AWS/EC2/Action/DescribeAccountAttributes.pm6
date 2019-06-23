use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::EC2::Response::DescribeAccountAttributesResponse;
use Amazon::AWS::Utils;

my %attributes;

constant myclass := (class Amazon::AWS::EC2::Action::DescribeAccountAttributes is export
  does XML::Class[
    xml-element   => 'DescribeAccountAttributes',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = BEGIN do { ::?CLASS.^name.split('::')[* - 1] };

  has Str  $.AttributeName    is xml-element is rw;  #= supported-platforms | default-vpc
  has Bool $.DryRun           is xml-element is rw;

  submethod BUILD (
    :$attributeName,
    :$dryRun,
    # For deserialization purposes, only!
    :$!AttributeName = '',
    :$!DryRun        = False,
    
  ) { 
    # Abstract away into a sub done by Actions role?
    my $dieMsg = qq:to/DIE/.chomp;
      Invalid Attribute value. Valid value should be any of:
      { %attributes<AttributeName|Table> }
      DIE
     
    $!AttributeName     = $attributeName  if $attributeName.defined;
    die $dieMsg unless $!AttributeName.defined.not ||
                       $!AttributeName.chars.not   ||
                       $!AttributeName ~~ %attributes<AttributeName|ValidValues>.any;
    
    $!DryRun        = $dryRun     if $dryRun.defined;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    # Should already be sorted.
    my @args = (
      DryRun        => $.DryRun,
      Version       => '2016-11-15'
    );
    @args.unshift: Pair.new('AttributeName', $.AttributeName)
      if $.AttributeName.defined && $.AttributeName.chars;
    
    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }
  
  method getAccountAttributeNames {
    %attributes<AttributeName|ValidValues>
  }
  
});

BEGIN {
  %attributes = getAttributeData(myclass)
}

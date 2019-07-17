use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::EC2::Response::DescribeVolumeAttributeResponse;
use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Action::DescribeVolumeAttribute is export
  does XML::Class[
    xml-element   => 'DescribeVolumeAttribute',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str  $.Attribute    is xml-element  is xml-skip-null is rw;  #= autoEnableIO | productCodes
  has Bool $.DryRun       is xml-element  is xml-skip-null is rw;
  has Str  $.VolumeId     is xml-element  is xml-skip-null is rw;

  my $badAttrValMsg;

  submethod BUILD (
    :$attribute,
    :$dryRun,
    :$volumeId,
    # For deserialization purposes, only!
    :$!Attribute  = '',
    :$!DryRun     = False,
    :$!VolumeId   = ''
    
  ) { 
    # Abstract away into a sub done by Actions role?
    $badAttrValMsg //= qq:to/DIE/.chomp;
      Invalid Attribute value. Valid value should be any of:
      { %attributes<Attribute|Table> }
      DIE
     
    $!DryRun    = $dryRun    if $dryRun;
    $!Attribute = $attribute if $attribute.defined && $attribute.trim.chars;
    $!VolumeId  = $volumeId  if $volumeId.defined && $volumeId.trim.chars;
    
    die $badAttrValMsg unless
      $!Attribute.chars.not ||
      $!Attribute ~~ %attributes<Attribute|ValidValues>.any;
  }
  
  method Attribute is rw {
    Proxy.new:
      FETCH => -> $           { $!Attribute },
      
      STORE => -> $, Str $val { 
       die $badAttrValMsg unless $val ~~ %attributes<Attribute|ValidValues>.any; 
       $!Attribute = $val;
      }
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die '$!Attribute is required!' unless $!Attribute.chars;
    die '$!VolumeId is required!'  unless $!VolumeId.chars;
    
    # Keep things sorted. No encoding necessary.
    my @args;
    
    @args.append: (
      Attribute  => $!Attribute,
      DryRun     => $!DryRun,
      VolumeId   => $!VolumeId,
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
  
  method getAttributes {
    %attributes<Attribute|ValidValues>.Array
  }
  
};

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::DescribeVolumeAttribute
  );
}

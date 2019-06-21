use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::EC2::Response::DescribeInstanceAttributeResponse;
use Amazon::AWS::Utils;

my %attributes;

constant myclass := (class Amazon::AWS::EC2::Action::DescribeInstanceAttribute is export
  does XML::Class[
    xml-element   => 'DescribeInstanceAttribute',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str  $.Attribute     is xml-element is rw;  #= instanceType | kernel | ramdisk | userData | disableApiTermination | instanceInitiatedShutdownBehavior | rootDeviceName | blockDeviceMapping | productCodes | sourceDestCheck | groupSet | ebsOptimized | sriovNetSupport | enaSupport
  has Bool $.DryRun        is xml-element is rw;
  has Str  $.InstanceId    is xml-element is rw;

  submethod BUILD (
    :$attribute,
    :$dryRun,
    :$instanceId,
    # For deserialization purposes, only!
    :$!Attribute      = '',
    :$!DryRun         = False,
    :$!InstanceId     = '',
  ) { 
    # Abstract away into a sub done by Actions role?
    my $dieMsg = qq:to/DIE/.chomp;
      Invalid Attribute value. Valid value should be any of:
      { %attributes<Attribute|Table> }
      DIE
     
    $!Attribute     = $attribute  if $attribute.defined;
    die $dieMsg unless $!Attribute.defined.not ||
                       $!Attribute.chars.not   ||
                       $!Attribute ~~ %attributes<Attribute|ValidValues>.any;
    
    $!DryRun        = $dryRun     if $dryRun.defined;
    $!InstanceId    = $instanceId if $instanceId.defined;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die 'InstanceId is required!' 
      unless $.InstanceId.defined && $.InstanceId.trim.chars;
      
    die 'Attribute is required'
      unless $.Attribute.defined && $.Attribute.trim.chars;

    # Should already be sorted.
    my @args = (
      DryRun     => $.DryRun,
      InstanceId => $.InstanceId,
      Version    => '2016-11-15'
    );
    @args.unshift: Pair.new('Attribute', $.Attribute) 
      if $.Attribute.trim.chars;

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }
});

BEGIN {
  %attributes = getAttributeData(myclass)
}

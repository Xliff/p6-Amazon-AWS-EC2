use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::DescribeNetworkInterfaceAttributeResponse;

my %attributes;

constant myclass := (
  class Amazon::AWS::EC2::Action::DescribeNetworkInterfaceAttribute is export
    does XML::Class[
      xml-element   => 'DescribeNetworkInterfaceAttribute',
      xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
    ]
  {
    also does Amazon::AWS::Roles::Eqv;

    my $c = ::?CLASS.^name.split('::')[* - 1];

    has Str  $.Attribute             is xml-element is xml-skip-null is rw;  #= description | groupSet | sourceDestCheck | attachment
    has Bool $.DryRun                is xml-element is xml-skip-null is rw;
    has Str  $.NetworkInterfaceId    is xml-element is xml-skip-null is rw;

    submethod BUILD (
      :$attribute,
      :$dryRun,
      :$networkInterfaceId,
      # For deserialization purposes, only!
      :$!Attribute          = '',
      :$!DryRun             = False,
      :$!NetworkInterfaceId = '',
    ) { 
      # Abstract away into a sub done by Actions role?
      my $dieMsg = qq:to/DIE/.chomp;
        Invalid Attribute value. Valid value should be any of:
        { %attributes<Attribute|Table> }
        DIE
       
      $!DryRun        = $dryRun     if $dryRun;
      $!Attribute     = $attribute  if $attribute.defined && $attribute.trim.chars;
      
      die $dieMsg unless $!Attribute.chars.not   ||
                         $!Attribute ~~ %attributes<Attribute|ValidValues>.any;
      
      $!NetworkInterfaceId = $networkInterfaceId 
        if $networkInterfaceId.defined && $networkInterfaceId.trim.chars;
    }

    method run (:$raw)
      is also<
        do
        execute
      >
    {
      die 'NetworkInterfaceId is required!' 
        unless $!NetworkInterfaceId.defined && $!NetworkInterfaceId.chars;
        
      die 'Attribute is required'
        unless $!Attribute.defined && $!Attribute.chars;

      # Should already be sorted.
      my @args = (
        Attribute          => $!Attribute,
        DryRun             => $!DryRun,
        NetworkInterfaceId => $!NetworkInterfaceId,
        Version            => '2016-11-15'
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
      %attributes<Attribute|ValidValues>.Array;
    }
    
  }
);

BEGIN {
  %attributes = getAttributeData(myclass)
}

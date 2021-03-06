use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::DescribeSnapshotAttributeResponse;

my %attributes;

constant myclass := (
  class Amazon::AWS::EC2::Action::DescribeSnapshotAttribute is export
    does XML::Class[
      xml-element   => 'DescribeSnapshotAttribute',
      xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
    ]
  {
    also does Amazon::AWS::Roles::Eqv;

    my $c = ::?CLASS.^name.split('::')[* - 1];

    has Str  $.Attribute     is xml-element is xml-skip-null is rw;  #= productCodes | createVolumePermission
    has Bool $.DryRun        is xml-element is xml-skip-null is rw;
    has Str  $.SnapshotId    is xml-element is xml-skip-null is rw;

    submethod BUILD (
      :$attribute,
      :$dryRun,
      :$snapshotId,
      # For deserialization purposes, only!
      :$!Attribute  = '',
      :$!DryRun     = False,
      :$!SnapshotId = '',
    ) { 
      # Abstract away into a sub done by Actions role?
      my $dieMsg = qq:to/DIE/.chomp;
        Invalid Attribute value. Valid value should be any of:
        { %attributes<Attribute|Table> }
        DIE
       
      $!Attribute     = $attribute  if $attribute.defined;
      $!DryRun        = $dryRun     if $dryRun;
      $!SnapshotId    = $snapshotId if $snapshotId.defined;
      
      die $dieMsg unless $!Attribute.defined.not ||
                         $!Attribute.chars.not   ||
                         $!Attribute ~~ %attributes<Attribute|ValidValues>.any;
      
    }

    method run (:$raw)
      is also<
        do
        execute
      >
    {
      die 'SnapshotId is required!' 
        unless $!SnapshotId.defined && $!SnapshotId.chars;
        
      die 'Attribute is required'
        unless $!Attribute.defined && $!Attribute.chars;

      # Should already be sorted. No encoding necessary.
      my @args = (
        Attribute  => $!Attribute,
        DryRun     => $!DryRun,
        SnapshotId => $!SnapshotId,
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
      %attributes<Attribute|ValidValues>.Array;
    }
    
  }
  
  
);

BEGIN {
  %attributes = getAttributeData(myclass)
}

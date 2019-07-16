use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::CreateNetworkAclResponse;

class Amazon::AWS::EC2::Action::CreateNetworkAcl is export
  does XML::Class[
    xml-element   => 'CreateNetworkAcl',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool $.DryRun  is xml-element is xml-skip-null is rw;
  has Str  $.VpcId   is xml-element is xml-skip-null is rw;

  submethod BUILD (
    :$vpcId,
    :$dryRun,
    # For deserialization purposes, only!
    :$!DryRun = False,
    :$!VpcId  = '',
  ) { 
    $!VpcId  = $vpcId  if $vpcId.defined && $vpcId.trim.chars;
    $!DryRun = $dryRun if $dryRun;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die 'VpcId is required!' 
      unless $!VpcId.defined && $!VpcId.chars;

    # Should already be sorted.
    my @args = (
      DryRun  => $!DryRun,
      vpcId   => $!VpcId,
      Version => '2016-11-15'
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

}

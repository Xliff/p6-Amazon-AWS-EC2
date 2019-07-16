use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

use Amazon::AWS::EC2::Response::DeleteNetworkInterfaceResponse;

class Amazon::AWS::EC2::Action::DeleteNetworkInterface is export
  does XML::Class[
    xml-element   => 'DeleteNetworkInterface',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool $.DryRun             is xml-element is xml-skip-null is rw;
  has Str  $.NetworkInterfaceId is xml-element is xml-skip-null is rw;

  submethod BUILD (
    :$dryRun,
    :$networkInterfaceId,
    # For deserialization purposes, only!
    :$!DryRun  = False,
    :$!NetworkInterfaceId = '',
  ) { 
    $!DryRun             = $dryRun             if $dryRun;
    $!NetworkInterfaceId = $networkInterfaceId if $networkInterfaceId.defined;
  }
  
  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die 'NetworkInterfaceId is required!' 
      unless $!NetworkInterfaceId.defined && $!NetworkInterfaceId.chars;
  
    # Should already be sorted.
    my @args = (
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

}

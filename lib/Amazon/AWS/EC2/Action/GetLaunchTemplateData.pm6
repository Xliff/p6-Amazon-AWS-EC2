use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::EC2::Response::GetLaunchTemplateDataResponse;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::GetLaunchTemplateData is export
  does XML::Class[
    xml-element   => 'GetLaunchTemplateData',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool $.DryRun        is xml-element is rw;
  has Str  $.InstanceId    is xml-element is rw;

  submethod BUILD (
    :$dryRun,
    :$instanceId,
    # For deserialization purposes, only!
    :$!DryRun         = False,
    :$!InstanceId     = ''
  ) { 
    $!DryRun     = $dryRun     if $dryRun;
    $!InstanceId = $instanceId if $instanceId.defined && $instanceId.trim.chars;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die 'InstanceId is required!' unless $!InstanceId.chars;

    # Should already be sorted.
    my @args = (
      DryRun     => $!DryRun,
      InstanceId => $!InstanceId,
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

}

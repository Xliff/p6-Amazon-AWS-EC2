use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::GetLaunchTemplateDataResponse;

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
    my $i = ($instanceId // '').trim;
    
    $!DryRun     = $dryRun if $dryRun;
    $!InstanceId = $i      if $i.chars;
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

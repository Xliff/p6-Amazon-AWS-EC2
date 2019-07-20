use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::GetConsoleScreenshotResponse;

class Amazon::AWS::EC2::Action::GetConsoleScreenshot is export
  does XML::Class[
    xml-element   => 'GetConsoleScreenshot',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool $.DryRun                 is xml-element                     is rw;
  has Str  $.InstanceId is required is xml-element('item', :over-ride) is rw;
  has Bool $.WakeUp                 is xml-element                     is rw;

  submethod BUILD (
    :$dryRun,
    :$instanceId,
    :$wakeUp,
    # For deserialization purposes, only!
    :$!DryRun         = False,
    :$!InstanceId     = '',
    :$!WakeUp         = True
  ) { 
    my $i = ($instanceId // '').trim;
    
    $!DryRun     = $dryRun  if $dryRun;
    $!InstanceId = $i       if $i.chars;
    $!WakeUp     = $wakeUp  if $wakeUp;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die "InstanceId is required!" unless $!InstanceId.chars;
    
    # Should already be sorted.
    my @args = (
      DryRun     => $!DryRun,
      InstanceId => $!InstanceId,
      Version    => '2016-11-15',
      WakeUp     => $!WakeUp
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

use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::EC2::Response::CreateDefaultSubnetResponse;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::CreateDefaultSubnet is export
  does XML::Class[
    xml-element   => 'CreateDefaultSubnet',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str  $.AvailabilityZone  is xml-element is xml-skip-null is rw;
  has Bool $.DryRun            is xml-element is xml-skip-null is rw;

  submethod BUILD (
    :$availabilityZone,
    :$dryRun,
    # For deserialization purposes, only!
    :$!DryRun           = False,
    :$!AvailabilityZone = '',
  ) { 
    $!AvailabilityZone = $availabilityZone if $availabilityZone.defined;
    $!DryRun           = $dryRun           if $dryRun;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die 'AvailabilityZone is required!' 
      unless $.AvailabilityZone.defined && $.AvailabilityZone.trim.chars;

    # Should already be sorted.
    my @args = (
      DryRun  => $.DryRun,
      AvailabilityZone => $.AvailabilityZone,
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

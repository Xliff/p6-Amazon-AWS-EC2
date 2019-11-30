use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::DeleteSnapshotResponse;

class Amazon::AWS::EC2::Action::DeleteSnapshot is export
  does XML::Class[
    xml-element   => 'DeleteSnapshot',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool $.DryRun        is xml-element is xml-skip-null is rw;
  has Str  $.SnapshotId    is xml-element is xml-skip-null is rw;

  submethod BUILD (
    :$dryRun,
    :$snapshotId,
    # For deserialization purposes, only!
    :$!DryRun     = False,
    :$!SnapshotId = '',
  ) { 
    $!DryRun     = $dryRun     if $dryRun;
    $!SnapshotId = $snapshotId if $snapshotId.defined && $snapshotId.trim.chars;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die 'SnapshotId is required!' 
      unless $!SnapshotId.defined && $!SnapshotId.chars;

    # Should already be sorted.
    my @args = (
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

}

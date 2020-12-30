use v6.d;

use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use XML::Class;

use Amazon::AWS::EC2::Response::DescribeInstanceEventNotificationAttributesResponse;

class Amazon::AWS::EC2::Action::DescribeInstanceEventNotificationAttributes is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^shortname;

  has Bool    $.DryRun    is xml-element    is xml-skip-null          is rw;

  submethod BUILD (:$dryRun, :$!DryRun = False) {
    $!DryRun = $dryRun if $dryRun;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    # Should already be sorted.
    my @args = (
      DryRun     => $!DryRun,
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

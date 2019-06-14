use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::EC2::Response::GetConsoleOutputResponse;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::GetConsoleOutput is export
  does XML::Class[
    xml-element   => 'GetConsoleOutput',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool $.DryRun                 is xml-element is rw;
  has Str  $.InstanceId is required is xml-element is rw;
  has Bool $.Latest                 is xml-element is rw;

  submethod BUILD (
    Bool :$!DryRun         = False,
    Str  :$!InstanceId,
    Bool :$!Latest
  ) { }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die "InstanceId is required!" unless $.InstanceId.defined;

    # Should already be sorted.
    my @args = (
      DryRun     => $.DryRun,
      InstanceId => $.InstanceId,
    );
    @args.push: Pair.new('Latest', $.Latest.Str) if $.Latest.defined;
    @args.push: Pair.new('Version', '2016-11-15');

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      Amazon::AWS::EC2::Response::GetConsoleOutputResponse.from-xml($xml);
  }

}

use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::DescribeAggregateIdFormatResponse;

class Amazon::AWS::EC2::Action::DescribeAggregateIdFormat is export
  does XML::Class[
    xml-element   => 'DescribeAggregateIdFormat',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool $.DryRun  is xml-element is xml-skip-null is rw;

  submethod BUILD (
    :$dryRun  = False,
    # For serialization purposes, ONLY!
    :$!DryRun = False,
  ) {
    $!DryRun = $dryRun if $dryRun;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    my @args.append: (
      DryRun        => $.DryRun,
      Version       => '2016-11-15'
    );

   # XXX - Add error handling to makeRequest!
   my $xml = makeRequest(
     "?Action={$c}&{ @args.map({ "{.key}={.value}" }).join('&') }"
   );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }

};

use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::DescribeAccountAttributesResponse;

my %attributes;

class Amazon::AWS::EC2::Action::DescribeAccountAttributes is export
  does XML::Class[
    xml-element   => 'DescribeAccountAttributes',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str  @.AttributeNames    is xml-element('item') is xml-container('attributeNameSet') is xml-skip-null is rw;  #= supported-platforms | default-vpc
  has Bool $.DryRun            is xml-element                                              is xml-skip-null is rw;

  submethod BUILD (
    :@attributeNames,
    :$dryRun,
    # For deserialization purposes, only!
    :@!AttributeNames,
    :$!DryRun         = False,

  ) {
    # Abstract away into a sub done by Actions role?
    my $dieMsg = qq:to/DIE/.chomp;
      Invalid AttributeName value. Valid value should be any of:
      { %attributes<AttributeNames|Table> }
      DIE

    @!AttributeNames = @attributeNames.map({
      when Str {
        when %attributes<AttributeNames|ValidValues>.any
          { $_ }

        default {
          die qq:to/DIE/.chomp;
            Invalid value for AttributeName. Must be one of:
              { %attributes<AttributeNames|Table> }
            DIE
        }
      }

      default    { die $dieMsg }
    }) if @attributeNames;

    $!DryRun = $dryRun if $dryRun.defined;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    # Keep things sorted.
    my @args;
    if @!AttributeNames {
      my @AttributeArgs;
      my $cnt = 1;
      @AttributeArgs.push: Pair.new("AttributeName.{$cnt++}", $_)
        for @!AttributeNames;        
      @args.append: @AttributeArgs;
    }
    @args.append: (
      DryRun        => $!DryRun,
      Version       => '2016-11-15'
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

  method getAccountAttributeNames {
    %attributes<AttributeNames|ValidValues>.Array
  }

};

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::DescribeAccountAttributes
  );
}

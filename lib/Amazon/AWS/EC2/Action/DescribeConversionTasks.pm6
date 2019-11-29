use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::DescribeConversionTasksResponse;

class Amazon::AWS::EC2::Action::DescribeConversionTasks is export
  does XML::Class[
    xml-element   => 'DescribeConversionTasks',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str  @.ConversionTaskIds  is xml-element('item') is xml-container('conversionTaskSet') is xml-skip-null is rw;
  has Bool $.DryRun             is xml-element                                               is xml-skip-null is rw;

  submethod BUILD (
    :@conversionTasks,
    :$dryRun,
    # For deserialization purposes, only!
    :@!ConversionTaskIds,
    :$!DryRun            = False,

  ) {
    @!ConversionTaskIds = @conversionTasks.map({
      when Str    { $_     }

      default     {
        die qq:to/DIE/.chomp;
Invalid type '{ .^name }' found in \@conversionTasks. This parameter will {''
} only accept Str objects
DIE

      }
    }) if @conversionTasks;

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
    if @.ConversionTaskIds {
      my @ConversionTaskIdArgs;
      my $cnt = 1;
      for @.ConversionTaskIds {
        @ConversionTaskIdArgs.push: Pair.new("ConversionTaskId.{$cnt++}", .value)
          for .pairs;
      }
      @args.append: @ConversionTaskIdArgs;
    }
    @args.append: (
      DryRun        => $.DryRun,
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

};

use v6.c;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Types::Instance;

use Amazon::AWS::EC2::Response::StartInstances;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::StartInstances is export
  does XML::Class[
    xml-element   => 'StartInstances',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  has Str  $.AdditionalInfo                                   is xml-element               is rw;
  has Bool $.DryRun                                           is xml-element               is rw;
  has Str  @.InstanceIds   is xml-container('instancesIdSet') is xml-element('instanceId') is rw;

  submethod BUILD (
    :$!AdditionalInfo? = '',
    :$!DryRun = False,
    :@instances
  ) {
    when @instances.all ~~ Str {
      @!InstanceIds = @instances;
    }
    when @instances.all ~~ Amazon::AWS::EC2::Instance {
      @!InstanceIds = @instances.map( *.instanceID );
    }
    default {
      die qq:to/DIE/.chomp;
Invalid value passed to \@instances. Should only contain Instance objects, but contains:
{ @instances.map( *.^name ).unique.join(', ') }
DIE

    }
  }

  method run
    is also<
      do
      execute
    >
  {
    my $c = 1;
    my @InstanceArgs;
    @InstanceArgs.push: Pair.new("InstanceId.{$c++}", $_) for @.InstanceIds;
    @InstanceArgs.say;

    # Should already be sorted.
    my @args = (
      DryRun         => $.DryRun,
      |@InstanceArgs,
      Version        => '2016-11-15'
    );
    @args.unshift: Pair.new('AdditionalInfo', $.AdditionalInfo)
      if $.AdditionalInfo.chars;

    # XXX - Add error handling to makeRequest!
    Amazon::AWS::EC2::Response::StartInstances.from-xml(
      makeRequest(
        "?Action=StartInstances&{ @args.map({ "{.key}={.value}" }).join('&') }"
      )
    );
  }

}

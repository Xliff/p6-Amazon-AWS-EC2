use v6.c;

use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::EC2::Instance;
#use Amazon::AWS::EC2::Response::StartInstances;

class Amazon::AWS::EC2::Action::StartInstances is export {
  has Str  $.AdditionalInfo;
  has Bool $.DryRun;
  has Str  @.InstanceIds;

  submethod BUILD (
    :$!AdditionalInfo? = '',
    :$!DryRun = False,
    :@instances
  ) {
    when @instances.all ~~ Str {
      @!InstanceIds = @instances;
    }
    when @instances.all ~~ Amazon::AWS::EC2::Instance {
      @!InstanceIds = @instances.map( *.InstanceID );
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
    #Amazon::AWS::EC2::Response::StartInstances.from-xml(
      makeRequest(
        "?Action=StartInstances&{ @args.map({ "{.key}={.value}" }).join('&') }"
      )
    #);
  }

}

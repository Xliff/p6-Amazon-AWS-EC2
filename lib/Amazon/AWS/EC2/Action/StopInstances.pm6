use v6.c;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Types::Instance;

use Amazon::AWS::EC2::Response::StopInstances;
use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::StopInstances is export
  does XML::Class[
    xml-element   => 'StopInstances',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;
  
  has Bool $.DryRun                                         is xml-element               is rw;
  has Bool $.Force                                          is xml-element               is rw;
  has Bool $.Hibernate                                      is xml-element               is rw;
  has Str  @.InstanceIds is xml-container('instancesIdSet') is xml-element('instanceId') is rw;

  submethod BUILD (
    :$!DryRun    = False,
    :$!Force     = False,
    :$!Hibernate = False,
    :@instances
  ) {
    @!InstanceIds = do given @instances {
      when .all ~~ Str      { @instances                     }
      when .all ~~ Instance { @instances.map( *.instanceID ) }
      default {
        die qq:to/DIE/.chomp;
Invalid value passed to \@instances. Should only contain EC2 Instance objects or strings, but contains:
{ @instances.grep( *.^name ne <Amazon::AWS::EC2::Instance Str>.any  ).map( *.^name ).unique
            .join(', ') }
DIE

      }
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
      Force          => $.Force,
      Hibernate      => $.Hibernate,
      |@InstanceArgs,
      Version        => '2016-11-15'
    );

    # XXX - Add error handling to makeRequest!
    Amazon::AWS::EC2::Response::StopInstances.from-xml(
      makeRequest(
        "?Action=StopInstances&{ @args.map({ "{.key}={.value}" }).join('&') }"
      )
    );
  }

}

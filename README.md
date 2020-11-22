# p6-Amazon-AWS-EC2
Client to communicate with the Amazon AWS EC2 service using Perl6.

Perl6 source to a small program that can start and stop AWS EC2 Instances:

```perl6
use v6.d;

use Amazon::AWS::EC2::Action::DescribeInstances;
use Amazon::AWS::EC2::Action::StartInstances;
use Amazon::AWS::EC2::Action::StopInstances;

sub MAIN (
  :$name,           #= Use an instance name
  :$id,             #= Use an instance ID
  :$key   is copy,  #= Key of tag to use in search. Not to be used with --name
  :$value is copy,  #= Value of tag to search for. Not to be used with --name
  :$start = False,  #= Start an instance
  :$stop  = False,  #= Stop an instance
) {
  die 'Must use either --start or --stop' unless $start || $stop;
  die 'Must use either --start or --stop' if     $start && $stop;

  die 'Cannot use --name with --key or --value'
    if $name.defined && ($key.defined || $value.defined);

  my $instanceIDs = do gather {
    when $name.defined {
      ($key, $value) = ('Name', $name);
      proceed;
    }

    when $key.defined {
      (
        DescribeInstances.new
                        .run
                        .reservations
                        .map( *.instances[0] )
                        .grep(
                          *.tags.grep({ .key eq $key && .value eq $value } )
                        )
                        .map({ take .instanceId })
      );
    }

    when $id.defined  { take $id }
  };

  die 'Could not find instance ID!' unless $instanceIDs.elems;

  try {
    CATCH {
      default {
        say "Could not { $start ?? 'start' !! 'stop' } instance '{
             $instanceID }':\n{ .message }";
        .rethrow;
      }
    }

    my %i = (instance-ids => $instanceIDs).Hash;

    my $r = $start ?? StartInstances.new( |%i ).run
                   !! StopInstances.new(  |%i ).run;

    for $r.instance-states.Array {
      say "{ .instanceID }: State is now: { .currentState.name }";
    }
  }
}
```

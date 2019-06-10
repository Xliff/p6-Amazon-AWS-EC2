use v6.d;

use Amazon::AWS::Action::DescribeInstances;
use Amazon::AWS::Action::StartInstances;

sub MAIN (
  :$name,           #= Use an instance name
  :$id,             #= Use an instance ID
  :$key   is copy,  #= Key of tag to use in search. Not to be used with --name
  :$value is copy   #= Value of tag to search for. Not to be used with --name
) {
  die 'Cannot use --name with --key or --value'
    if $name.defined && ($key.defined || $value.defined);

  my $instanceID = do {
    ($key, $value) = ('Name', $name) if $name.defined;
    DescribeInstances.new
                     .run
                     .reservations
                     .map( *.instances[0] )
                     .grep(
                       *.tags.grep({ .key eq $key && .value eq $value } )
                     )
                     .map( *.instanceId )[0];
    }

    when $id.defined { $id }
  };

  die 'Could not find instance ID!' unless $instanceID.defined;

  try {
    CATCH {
      default {
        say "Could not start instance '{ $instanceID }':\n{ .message }";
        .rethrow;
      }
    }

    my $r = StartInstances.new( :$instanceID ).run;
    say "Instance state is now: { $r.instance-states[0].currentState.name }";
  }
}

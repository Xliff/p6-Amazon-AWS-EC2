use v6.d;

use Amazon::AWS::Action::DescribeInstances;
use Amazon::AWS::Action::StartInstances;

sub MAIN (
  :$name    #= Use an instance name
  :$id      #= Use an instance ID
) {
  my $instanceID = do {
    when $name.defined {
      DescribeInstances.new
                       .run
                       .reservations
                       .map( *.instances[0] )
                       .grep(
                         *.tags.grep({ .key eq "Name" && .value eq $name } )
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

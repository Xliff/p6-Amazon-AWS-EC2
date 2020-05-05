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

  my $instanceID = do {
    when $name.defined {
      ($key, $value) = ('Name', $name);
      (
        DescribeInstances.new
                        .run
                        .reservations
                        .map( *.instances[0] )
                        .grep(
                          *.tags.grep({ .key eq $key && .value eq $value } )
                        )
                        .map( *.instanceId )
      )[0];
    }

    when $id.defined  { $id }
  };

  die 'Could not find instance ID!' unless $instanceID.defined;

  try {
    CATCH {
      default {
        say "Could not stop instance '{ $instanceID }':\n{ .message }";
        .rethrow;
      }
    }

    my %i = (instance-ids => $instanceID.Array).Hash;

    my $r = $start ?? StartInstances.new( |%i ).run
                   !! StopInstances.new(  |%i ).run;
    say "Instance state is now: { $r.instance-states[0].currentState.name }";
  }
}

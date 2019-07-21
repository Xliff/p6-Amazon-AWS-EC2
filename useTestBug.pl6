# my @modules = <
#   CopySnapshot
#   GetLaunchTemplateData
# >;

my @modules = <
  GetLaunchTemplateData
>;

my %class;
for @modules {
  .say;
  quietly {
    CATCH {
      default { .message.say }
    }
    %class{$_} := try require ::("Amazon::AWS::EC2::Action::$_");
  }
}

%class.gist.say;
say "Nil classes:";
for %class.kv -> $k, $v {
  $k.say if $v === Nil;
}

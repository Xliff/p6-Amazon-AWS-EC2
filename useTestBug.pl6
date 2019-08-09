# my @modules = <
#   CopySnapshot
#   GetLaunchTemplateData
# >;

# cw: This won't work!
# my @modules = <
#   CopySnapshot
#   GetLaunchTemplateData
# >;

# cw: This works!
my @modules = <
  GetLaunchTemplateData
  CopySnapshot
>;

my %class;
for @modules {
  .say;
  quietly {
    CATCH { default { .message.say } }
    
    require ::("Amazon::AWS::EC2::Action::$_");
    %class{$_} := ::("Amazon::AWS::EC2::Action::$_");
  }
}

%class.gist.say;
say "Nil classes:";
for %class.kv -> $k, $v {
  $k.say if $v === Nil;
}

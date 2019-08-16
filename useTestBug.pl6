# my @modules = <
#   CopySnapshot
#   GetLaunchTemplateData
# >;

# cw: This won't work!
my @modules = <
  CopySnapshot
  GetLaunchTemplateData
>;

# cw: This works!
# my @modules = <
#   GetLaunchTemplateData
#   CopySnapshot
# >;

my %class;
for @modules {
  .say;
  CATCH {
    default { say "EXCEPTION ", .^name, ": ", .message }
  }
  my $mod = "Amazon::AWS::EC2::Action::$_";
  require ::($mod);
  %class{$_} := ::($mod);
}

%class.gist.say;
say "Nil classes:";
for %class.kv -> $k, $v {
  $k.say if $v === Nil;
}

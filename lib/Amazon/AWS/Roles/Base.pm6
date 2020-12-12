use v6.d;

role Amazon::AWS::Roles::Base {

  method pairs {
    my @p;
    for self.^attributes.sort( *.name.substr(2) ) {
      my $n = .name.substr(2);
      my $v = self."$n"();
      next unless $v.defined;

      given $v {
        when Str | Num | Int | Bool {
          @p.push: Pair.new($n, self."$n"()) if self."$n"().defined;
        }
        default {
          next unless $v.defined;
          {
            # when .type ~~ Positional && .type.of ~~ Tag
            when $v.^shortname eq 'Tag' {
              for $v.Array {
                next unless $_;
                next unless .key.defined;
                @p.push: Pair.new("tag:{.key}", .value)
              }
            }
            default {
              @p.push: Pair.new("{$n}.{.key}", .value) for $v.pairs;
            }
          }
        }
      }
    }
    @p;
  }

  method handlePercentageAsString ($_ is raw) {
    when Int { ~$_ ~ '%' }
    when Str { $_        }

    when Num {
      my $p = $_ * 100;
      die 'Percentage > 100 given for $!progress. Must be 1..100' if $p > 100;
      $p.fmt('%d') ~ '%'
    }

    default {
      die "Invalid type '{ .^name }' used for \$!{ .VAR.name }!";
    }
  }

  method handleDateTimeAsString ($_ is raw) {
    when Instant  { .DateTime; proceed  }
    when Str      { $_                  }

    when DateTime {
      my $d = .utc;
      $d ~~ s/'.'\d+//;
      $d ~~ s/Z$/000Z/;
      $d
    }

    default {
      die "Invalid type '{ .name }' used for \$!{ .VAR.name }!";
    }
  }

}

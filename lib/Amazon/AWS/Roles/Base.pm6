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
            when $n ~~ /^ 'tags'/ {
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

}

use v6.d;

use Test;

unit package Amaszon::AWS::EC2::Tests::TestTemplate;

our %classes is export;

sub runActionResponseTests(\action, \response, $fixup?) is export {    
  my ($o, $ro, $x);
  
  my $c = action.^name;
  
  plan 4;
  
  lives-ok { $o = action.new                  }, "Can Instantiate $c";
  
  $fixup($o) if $fixup.defined;
  
  lives-ok { $x = $o.run(:raw)                }, "Can execute {$c}.run";
  ok       { $x.starts-with("<?xml version")  }, "Returned value looks XMLish";
  # diag $x;
  lives-ok { $ro = response.from-xml($x)      }, "Can Instantiate response object from XML";
  # diag $ro.gist;
}

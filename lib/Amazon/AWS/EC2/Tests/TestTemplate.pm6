use v6.d;

use Test;

unit package Amaszon::AWS::EC2::Tests::TestTemplate;

our %classes is export;

constant actionResponseTests is export = 4;

sub runActionResponseTests(\action, \response, $fixup?, :$plan = True) is export {    
  my ($o, $ro, $x);
  
  my $c = action.^name;
  
  plan actionResponseTests if $plan;
  
  lives-ok { $o = action.new                  }, "Can Instantiate $c";
  
  $fixup($o) if $fixup.defined;
  
  lives-ok { CATCH {  
               default { use fatal; $*ERR.say; "oops, $_" } 
             } 
             # Can generate a fatal exception and return a false positive!!
             $x = $o.run(:raw)                }, "Can execute {$c}.run";
  ok       { $x.starts-with("<?xml version")  }, "Returned value looks XMLish";
  diag $x;
  lives-ok { CATCH {  
               default { $*ERR.say; "oops, $_" } 
             } 
             $ro = response.from-xml($x)      }, "Can Instantiate response object from XML";
  diag $ro.gist;
}

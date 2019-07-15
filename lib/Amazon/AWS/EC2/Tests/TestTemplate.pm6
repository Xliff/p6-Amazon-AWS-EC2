use v6.d;

use Test;

unit package Amaszon::AWS::EC2::Tests::TestTemplate;

our %classes is export;

constant actionResponseTests is export = 5;

sub runTestCore(\package, :$loader, :$fixup, :$plan = True) is export {
  my $c = package.^name.split('::')[* - 1];
  
  # YYY- Determine why quietly is needed, here!
  my ($action, $response);
  quietly {
    $action := do {
      if not %classes{$c}:exists {
        %classes{$c} := try require ::("Amazon::AWS::EC2::Action::{ $c }");
      }
      %classes{$c}
    };
    $response := do {
      if not %classes{"{$c}Response"}:exists {
        %classes{"{$c}Response"} := 
          try require ::("Amazon::AWS::EC2::Response::{ $c }Response");
      }
      %classes{"{$c}Response"};
    };
    
    &( $loader )() if $loader.defined;
  }
  
  runActionResponseTests($action, $response, :$fixup, :$plan)
}

sub runActionResponseTests(\action, \response, :$fixup, :$plan = True) {    
  my ($o, $ro, $x);
  
  my $c = action.^name;
  diag $c;
  
  plan actionResponseTests if $plan;
  
  lives-ok { $o = action.new                  }, "Can Instantiate $c";
  
  $fixup($o) if $fixup.defined;
  
  lives-ok { 
     CATCH {  
       default { use fatal; $*ERR.say; "oops, $_" } 
     } 
     # Can generate a fatal exception and return a false positive!!
     $x = $o.run(:raw)                
  },                                             "Can execute {$c}.run";

  # WTF! No longer short circuiting?!
  ok        $x.defined && [&&](
              $x.chars,
              $x.starts-with("<?xml version");
            )                                  , "Returned value looks XMLish";
  # diag $x;
  lives-ok { CATCH {  
               default { 
                 $*ERR.say; 
                .rethrow;
               }
             } 
             $ro = response.from-xml($x)      }, "Deserialization does not throw an exception";
             
  isa-ok     $ro, response,                      "Response object is the correct type.";
  # diag $ro.gist;
  
  $ro;
}

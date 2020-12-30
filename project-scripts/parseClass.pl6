#!/usr/bin/env perl6
use v6.c;

use lib <. project-scripts>;

use ClassGeneration;

sub MAIN (
  Str  :$spider,            #= Spider all links at argument and generate classes from
                            #= all <a> tags. Generated classes are sent to their own file.
  #Str  :$pattern,          #= Pattern to use to filter links and extract class name.
  #Int  :$threads = 5,      #= Number of parallel threads. Used with --spider
  Str  :$url,               #= Generate a class from the given URL and send it to STDOUT.
  Bool :$response = False,  #= Generate classes from Response descriptions
  Bool :$action   = False   #= Generate classes from Action descriptions

) {
  when $spider.defined {
    #doSpider($spider, :$threads);
    doSpider($spider, :$response);
  }

  when $url.defined {
    makeClass($url, :$response, :$action).say;
  }

  default {
    say "Must specify --spider or --url!\n";
    say $*USAGE;
  }
}

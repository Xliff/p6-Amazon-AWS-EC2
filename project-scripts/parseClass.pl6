#!/usr/bin/env perl6
use v6.c;

use lib <. project-scripts>;

use ClassGeneration;

sub MAIN (
  Str :$spider,     #= Spider all links at argument and generate classes from
                    #= all <a> tags. Generated classes are sent to their own file.
  Str :$pattern,    #= Pattern to use to filter links and extract class name.
  Int :$batch = 5,  #= Size of parallel batches. Used with --spider
  Str :$url         #= Generate a class from the given URL and send it to STDOUT.

) {
  when $spider.defined {
    doSpider($spider, :$batch);
  }

  when $url.defined {
    makeClass($url).say;
  }

  default {
    say $*USAGE;
  }
}

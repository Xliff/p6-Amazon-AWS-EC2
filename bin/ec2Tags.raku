#!/usr/bin/env raku

use Amazon::AWS::Utils;
use Amazon::AWS::EC2::Action::CreateTags;
#use Amazon::AWs::EC2::Action::DeleteTags;

use Amazon::AWS::EC2::Types::Tag;

sub MAIN (
       *@resourceIds is copy,                  #= A list of AWS resource IDs
       :$tags,                                 #= Comma separated list of <tag>s.
                                               #= Where each <tag> must be in 'key:value'
                                               #= format
  Bool :$add                  = False,         #= Add <tag>
  Bool :delete(:$remove)      = False,         #= Remove <tag>
  Str  :$region               = default_region #= Region
) {
  die 'Must specify --add or --delete' unless $add ^^ $remove;

  my @tags = $tags.split(',').map({
    my ($key, $value) = do {
      die "Tags must be in 'key:value' format!"
        unless $_ && /\w+ ':' \w+/;
      .split(':');
    }
    Tag.new($key, $value);
  });

  @resourceIds.map( *.lc );
  die '@resourceIds must be Amazon AWS resource IDs'
    unless @resourceIds.all ~~ /^ <[a..z]>+ '-' <[a..z0..9]>+ $/;

  my %params = (
    resources => @resourceIds,
    tags      => @tags
  );

  my ($r, $op) = do if $add {
    [ CreateTags.new( |%params ).run(:$region), 'added' ];
  } elsif $remove {
    #[ DeleteTags.new( |%params ).run, 'deleted' ];
  }

  say "Tag {$op} { $r.return ?? '' !! 'un' }successfully.";
}

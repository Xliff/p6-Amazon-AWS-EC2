use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Filters::DescribeHostReservationOfferingsFilter;
use Amazon::AWS::EC2::Response::DescribeHostReservationOfferingsResponse;
use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::DescribeHostReservationOfferings is export
  does XML::Class[
    xml-element   => 'DescribeHostReservationOfferings',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                                    $.DryRun                                        is xml-element  is rw;
  has DescribeHostReservationOfferingsFilter  @.Filters      is xml-container('filterSet')     is xml-element  is rw;
  has Int                                     $.MaxDuration                                   is xml-element  is rw; # One year(31536000) or Three years(94608000)
  has Int                                     $.MaxResults                                    is xml-element  is rw;
  has Int                                     $.MinDuration                                   is xml-element  is rw; # One year(31536000) or Three years(94608000)
  has Str                                     $.OfferingId                                    is xml-element  is rw; 

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,      
    :@filters,
    :$maxDuration,  
    :$maxResults,   
    :$minDuration,  
    :$offeringId,   
    # For testing purposes only
    :$!DryRun       = False,
    :@!Filters,
    :$!MaxDuration  = 94608000,
    :$!MaxResults   = 500,
    :$!MinDuration  = 31536000,
    :$!OfferingId   = '',
  ) {
    $!OfferingId = $offeringId if $offeringId.defined;
    die '$!OfferingId MUST be a String!' unless $!OfferingId ~~ Str;
    
    if $minDuration {
      die '$minDuration must be an integer and have a value of 31536000, or 94608000'
      unless $minDuration == (31536000, 94608000).any;
      $!MinDuration = $minDuration;
    }
    if $maxDuration {
      die '$maxDuration must be an integer and have a value of 31536000, or 94608000'
        unless $maxDuration == (31536000, 94608000).any;
      $!MaxDuration = $maxDuration;
    }
    if $maxResults {
      die '$maxResult muet be an integer between 5 and 500'
        unless $maxResults ~~ 5..500;
      $!MaxResults = $maxResults;
    }
    
     
    if @filters {
      @!Filters = do given @filters {
        when .all ~~ Amazon::AWS::EC2::Filters::DescribeHostReservationOfferingsFilter 
          { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeHostReservationFilter objects, but contains:
          { @filters.map( *.^name ).unique.join('. ') }
          DIE

        }
      };
    }

  }

  method run (:$nextToken = '', :$raw)
    is also<
      do
      execute
    >
  {
    # Now limitations beyond the valid rage is given at https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeHostReservationOfferings.html
    # Code left here in case there was an omission.
    # die 'Cannot use @.HostReservation and $.maxResults in the same call to DescribeHostReservation'
    #   if $.MaxResults.defined && @.OfferingId;

    my @FilterArgs;
    my $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun      => $!DryRun,
        |@FilterArgs,
        MaxDuration => $!MaxDuration,
        MaxResults  => $!MaxResults,
        MinDuration => $!MinDuration
      );
      
      @args.append: Pair.new('OfferingId', $!OfferingId)
        if $.OfferingId.chars;
        
      @args.push: Pair.new('Version', '2016-11-15');
    }

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }

}

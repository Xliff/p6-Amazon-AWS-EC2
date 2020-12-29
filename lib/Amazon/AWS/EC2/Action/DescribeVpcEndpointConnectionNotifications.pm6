use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeVpcEndpointConnectionNotificationsFilter;
use Amazon::AWS::EC2::Response::DescribeVpcEndpointConnectionNotificationsResponse;

class Amazon::AWS::EC2::Action::DescribeVpcEndpointConnectionNotifications is export
  does XML::Class[
    xml-element   => 'DescribeVpcEndpointConnectionNotifications',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                $.DryRun                                                                  is xml-element   is rw;
  has Str                 $.ConnectionNotificationId                                                is xml-element   is rw;
  has Int                 $.MaxResults                                                              is xml-element   is rw;

  has DescribeVpcEndpointConnectionNotificationsFilter  @.Filters    is xml-container('filterSet')  is xml-element   is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :$connectionNotificationId,
    :$maxResults,
    # For testing purposes only
    :$!DryRun                   = False,
    :@!Filters,
    :$!ConnectionNotificationId = '',
    :$!MaxResults               = 1000
  ) {
    $!DryRun     = $dryRun     if $dryRun;
    $!MaxResults = $maxResults if $maxResults.defined;

    # Guessing, because range NOT specified here:
    # https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpcEndpointConnectionNotifications.html
    die '$maxResutlts must be an integer between 5 and 100'
      unless %*ENV<P6_AWS_TESTING>.defined || $!MaxResults ~~ 5..100;

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ Amazon::AWS::EC2::Filters::DescribeVpcEndpointConnectionNotificationsFilter { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeVpcEndpointConnectionNotificationsFilter objects, but contains:
          { @filters.map( *.^name ).unique.join('. ') }
          DIE

        }
      };
    }

  }

  method run (Str :$nextToken is copy, :$raw)
    is also<
      do
      execute
    >
  {
    $nextToken //= '';

    my @FilterArgs;
    my $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt}.{.key}", urlEncode(.value))
        for .pairs;
      $cnt++;
    }

    # Should already be sorted.
    my @args;

    if (my $nt = $nextToken.trim).chars {
      @args = ( nextToken => $nt );
    } else {
      @args.push:   (ConnectionNotificationId => $!ConnectionNotificationId)
        if $!ConnectionNotificationId.chars;
      @args.append: (
        DryRun         => $!DryRun,
        |@FilterArgs,
        MaxResults     => $!MaxResults,
        Version        => '2016-11-15'
      );
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

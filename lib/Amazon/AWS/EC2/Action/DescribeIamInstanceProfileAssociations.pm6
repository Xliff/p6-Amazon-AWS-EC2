use v6.d;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Filters::DescribeIamInstanceProfileAssociationsFilter;
use Amazon::AWS::EC2::Response::DescribeIamInstanceProfileAssociationsResponse;
use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeIamInstanceProfileAssociations is export
  does XML::Class[
    xml-element   => 'DescribeIamInstanceProfileAssociations',
    xml-namespace => "http://ec2.amazonaws.com/doc/2016-11-15/"
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str                                          @.AssociationIds is xml-element('item', :over-ride) is xml-container('associationIdSet') is xml-skip-null is rw;
  has DescribeIamInstanceProfileAssociationsFilter @.Filters                                           is xml-container('filterSet')        is xml-skip-null is rw;
  has Int                                          $.MaxResults     is xml-element                                                          is xml-skip-null is rw;
 
  submethod BUILD (
    :@associationIds,
    :@filters,
    :$maxResults,
    # Testing purposes ONLY!
    :@!AssociationIds,
    :@!Filters,
    # No maximum given in the documentation
    :$!MaxResults = 500
  ) {
    $!MaxResults = $maxResults if $maxResults.defined;
    
    if @associationIds {
      @!AssociationIds //= do given @associationIds {
        when .all ~~ Str { $_ }
        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@associationIds. Should only contain 
          Str objects, but contains:
            { @associationIds.map( *.^name ).unique.join('. ') }
          DIE
        }
      }
    }
    
    if @filters {
      @!Filters //= do given @filters {
        when .all ~~ DescribeIamInstanceProfileAssociationsFilter    { $_ }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain 
          DescribeIamInstanceProfileAssociationsFilter objects, 
          but contains:
            { @filters.map( *.^name ).unique.join('. ') }
          DIE

        }
      }
    }
  }

  method run (:$raw = False)
    is also<
      do
      execute
    >
  {
    
    my @AssociationIdArgs;
    my $cnt = 1;
    @AssociationIdArgs.push: Pair.new("AssociationId.{$cnt++}", $_)
      for @!AssociationIds;
    
    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: 
        Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value))
          for .pairs;
    }
    
    # Should already be sorted.
    my @args = (
      |@AssociationIdArgs,
      |@FilterArgs,
      MaxResults => $!MaxResults,
      Version    => '2016-11-15'
    );

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

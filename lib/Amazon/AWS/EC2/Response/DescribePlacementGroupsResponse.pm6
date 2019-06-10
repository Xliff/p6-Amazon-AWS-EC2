use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::PlacementGroup;

class Amazon::AWS::EC2::Response::DescribePlacementGroupsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has PlacementGroup    @.placementGroups    is xml-element    is xml-container('placementGroupSet')      is rw; 
}
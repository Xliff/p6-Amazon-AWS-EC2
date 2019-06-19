use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ReservedInstancesListing;

class Amazon::AWS::EC2::Response::CreateReservedInstancesListingResponse is export
  does XML::Class[xml-element => 'CreateReservedInstancesListingResponse']
{
  also does Amazon::AWS::Roles::Response;

  has ReservedInstancesListing    @.reservedInstancesListingss    is xml-element    is xml-container('reservedInstancesListingsSet')      is rw; 
}
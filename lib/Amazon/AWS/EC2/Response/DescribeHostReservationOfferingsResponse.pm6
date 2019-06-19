use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::HostOffering;

class Amazon::AWS::EC2::Response::DescribeHostReservationOfferingsResponse is export
  does XML::Class[xml-element => 'DescribeHostReservationOfferingsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str             $.nextToken    is xml-element                                         is rw; 
  has HostOffering    @.offerings    is xml-element    is xml-container('offeringSet')      is rw; 
}
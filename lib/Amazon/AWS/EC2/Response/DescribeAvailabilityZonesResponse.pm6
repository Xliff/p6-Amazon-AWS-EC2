use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::AvailabilityZone;

class Amazon::AWS::EC2::Response::DescribeAvailabilityZonesResponse is export
  does XML::Class[xml-element => 'DescribeAvailabilityZonesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has AvailabilityZone    @.availability-zones    is xml-container('availabilityZoneInfo')    is rw; 
}

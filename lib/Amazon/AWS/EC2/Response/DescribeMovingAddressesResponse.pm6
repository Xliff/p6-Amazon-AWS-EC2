use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::MovingAddressStatus;

class Amazon::AWS::EC2::Response::DescribeMovingAddressesResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has MovingAddressStatus    @.movingAddressStatuss    is xml-element    is xml-container('movingAddressStatusSet')      is rw; 
  has Str                    $.nextToken               is xml-element                                                    is rw; 
}
use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Types::Response::MoveAddressToVpcResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.allocationId    is xml-element          is rw; 
  has Str    $.status          is xml-element          is rw;   #=  MoveInProgress | InVpc | InClassic
}
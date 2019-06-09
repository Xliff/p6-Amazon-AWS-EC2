use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::CancelledSpotInstanceRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.spotInstanceRequestId    is xml-element          is rw; 
  has Str    $.state                    is xml-element          is rw;   #=  active | open | closed | cancelled | completed
}
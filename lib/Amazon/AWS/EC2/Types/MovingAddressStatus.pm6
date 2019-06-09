use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::MovingAddressStatus is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.moveStatus    is xml-element          is rw;   #=  movingToVpc | restoringToClassic
  has Str    $.publicIp      is xml-element          is rw; 
}
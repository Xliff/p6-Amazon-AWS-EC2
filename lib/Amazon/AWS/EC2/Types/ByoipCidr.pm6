use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ByoipCidr is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.cidr             is xml-element    is xml-skip-null          is rw; 
  has Str    $.description      is xml-element    is xml-skip-null          is rw; 
  has Str    $.state            is xml-element    is xml-skip-null          is rw;   #=  advertised | deprovisioned | failed-deprovision | failed-provision | pending-deprovision | pending-provision | provisioned
  has Str    $.statusMessage    is xml-element    is xml-skip-null          is rw; 
}
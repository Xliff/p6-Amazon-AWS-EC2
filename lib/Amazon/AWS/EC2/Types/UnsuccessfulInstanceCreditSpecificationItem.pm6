use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::UnsuccessfulInstanceCreditSpecificationItemError;

class Amazon::AWS::EC2::Types::UnsuccessfulInstanceCreditSpecificationItem is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has UnsuccessfulInstanceCreditSpecificationItemError    $.error         is xml-element(:over-ride)    is xml-skip-null          is rw;
  has Str                                                 $.instanceId    is xml-element                is xml-skip-null          is rw; 
}

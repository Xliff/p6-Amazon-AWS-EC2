use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::UnsuccessfulInstanceCreditSpecificationItemError is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.code       is xml-element    is xml-skip-null          is rw;   #=  InvalidInstanceID.Malformed | InvalidInstanceID.NotFound | IncorrectInstanceState | InstanceCreditSpecification.NotSupported
  has Str    $.message    is xml-element    is xml-skip-null          is rw;
}

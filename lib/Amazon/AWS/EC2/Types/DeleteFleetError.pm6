use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::DeleteFleetError is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.code       is xml-element    is xml-skip-null          is rw;   #=  fleetIdDoesNotExist | fleetIdMalformed | fleetNotInDeletableState | unexpectedError
  has Str    $.message    is xml-element    is xml-skip-null          is rw;
}

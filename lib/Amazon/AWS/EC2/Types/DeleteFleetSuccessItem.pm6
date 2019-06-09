use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::DeleteFleetSuccessItem is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.currentFleetState     is xml-element          is rw;   #=  submitted | active | deleted | failed | deleted-running | deleted-terminating | modifying
  has Str    $.fleetId               is xml-element          is rw; 
  has Str    $.previousFleetState    is xml-element          is rw;   #=  submitted | active | deleted | failed | deleted-running | deleted-terminating | modifying
}
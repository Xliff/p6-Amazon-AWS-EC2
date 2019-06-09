use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::VpcEndpointConnection is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.creationTimestamp    is xml-element          is rw; 
  has Str    $.serviceId            is xml-element          is rw; 
  has Str    $.vpcEndpointId        is xml-element          is rw; 
  has Str    $.vpcEndpointOwner     is xml-element          is rw; 
  has Str    $.vpcEndpointState     is xml-element          is rw;   #=  PendingAcceptance | Pending | Available | Deleting | Deleted | Rejected | Failed | Expired
}
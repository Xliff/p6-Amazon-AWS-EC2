use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceStatusEvent;

class Amazon::AWS::EC2::Response::ModifyInstanceEventStartTimeResponse is export
  does XML::Class[xml-element => 'ModifyInstanceEventStartTimeResponse']
{
  also does Amazon::AWS::Roles::Response;

  has InstanceStatusEvent    $.event    is xml-element          is rw; 
}
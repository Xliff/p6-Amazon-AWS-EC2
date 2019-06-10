use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::UnsuccessfulItem;

class Amazon::AWS::EC2::Response::ReleaseHostsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str                 @.successful      is xml-element    is xml-container('successful')        is rw; 
  has UnsuccessfulItem    @.unsuccessful    is xml-element    is xml-container('unsuccessful')      is rw; 
}
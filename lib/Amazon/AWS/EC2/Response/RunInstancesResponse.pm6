use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::GroupIdentifier;
use Amazon::AWS::EC2::Types::Instance;

class Amazon::AWS::EC2::Response::RunInstancesResponse is export
  does XML::Class[xml-element => 'RunInstancesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has GroupIdentifier    @.groups           is xml-element('item', :over-ride)   is xml-skip-null  is xml-container('groupSet')       is rw;
  has Instance           @.instances        is xml-element('item', :over-ride)   is xml-skip-null  is xml-container('instancesSet')   is rw;
  has Str                $.ownerId          is xml-element                       is xml-skip-null                                     is rw;
  has Str                $.requesterId      is xml-element                       is xml-skip-null                                     is rw;
  has Str                $.reservationId    is xml-element                       is xml-skip-null                                     is rw;
}

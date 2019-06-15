use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Placement;
use Amazon::AWS::EC2::Types::UserData;

class Amazon::AWS::EC2::Types::ImportInstanceLaunchSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str          $.AdditionalInfo                       is xml-element                           is xml-skip-null                                        is rw;
  has Str          $.Architecture                         is xml-element                           is xml-skip-null                                        is rw;   #=  i386 | x86_64 | arm64
  has Str          @.GroupIds                             is xml-element('groupId')                is xml-skip-null    is xml-container('GroupIds')        is rw;
  has Str          @.GroupNames                           is xml-element('groupName')              is xml-skip-null    is xml-container('GroupNames')      is rw;
  has Str          $.InstanceInitiatedShutdownBehavior    is xml-element                           is xml-skip-null                                        is rw;   #=  stop | terminate
  has Str          $.InstanceType                         is xml-element                           is xml-skip-null                                        is rw;   #=  sub:Amazon::AWS::EC2::validInsanceTypes::checkInstanceType
  has Bool         $.Monitoring                           is xml-element                           is xml-skip-null                                        is rw;
  has Placement    $.Placement                            is xml-element(:over-ride)               is xml-skip-null                                        is rw;
  has Str          $.PrivateIpAddress                     is xml-element                           is xml-skip-null                                        is rw;
  has Str          $.SubnetId                             is xml-element                           is xml-skip-null                                        is rw;
  has UserData     $.UserData                             is xml-element(:over-ride)               is xml-skip-null                                        is rw;
}

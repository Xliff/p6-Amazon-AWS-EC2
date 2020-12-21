use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::InstanceTagNotificationAttribute is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.includeAllTagsOfInstance    is xml-element                        is xml-skip-null                                               is rw;
  has Str     @.instanceTagKeys             is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('instanceTagKeySet')      is rw;
}

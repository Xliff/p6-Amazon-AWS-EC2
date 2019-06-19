use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ConnectionNotification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    @.connectionEvents               is xml-element    is xml-skip-null    is xml-container('connectionEvents')      is rw; 
  has Str    $.connectionNotificationArn      is xml-element    is xml-skip-null                                              is rw; 
  has Str    $.connectionNotificationId       is xml-element    is xml-skip-null                                              is rw; 
  has Str    $.connectionNotificationState    is xml-element    is xml-skip-null                                              is rw;   #=  Enabled | Disabled
  has Str    $.connectionNotificationType     is xml-element    is xml-skip-null                                              is rw;   #=  Topic
  has Str    $.serviceId                      is xml-element    is xml-skip-null                                              is rw; 
  has Str    $.vpcEndpointId                  is xml-element    is xml-skip-null                                              is rw; 
}
use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::NetworkInterfaceAttachmentChanges is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.AttachmentId           is xml-element    is xml-skip-null          is rw; 
  has Bool    $.DeleteOnTermination    is xml-element    is xml-skip-null          is rw; 
}
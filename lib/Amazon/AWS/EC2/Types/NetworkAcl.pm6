use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::NetworkAclAssociation;
use Amazon::AWS::EC2::Types::NetworkAclEntry;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::NetworkAcl is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has NetworkAclAssociation    @.associations    is xml-element    is xml-skip-null    is xml-container('associationSet')      is rw; 
  has Bool                     $.default         is xml-element    is xml-skip-null                                            is rw; 
  has NetworkAclEntry          @.entrys          is xml-element    is xml-skip-null    is xml-container('entrySet')            is rw; 
  has Str                      $.networkAclId    is xml-element    is xml-skip-null                                            is rw; 
  has Str                      $.ownerId         is xml-element    is xml-skip-null                                            is rw; 
  has Tag                      @.tags            is xml-element    is xml-skip-null    is xml-container('tagSet')              is rw; 
  has Str                      $.vpcId           is xml-element    is xml-skip-null                                            is rw; 
}
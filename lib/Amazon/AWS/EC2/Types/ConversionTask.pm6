use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ImportInstanceTaskDetails;
use Amazon::AWS::EC2::Types::ImportVolumeTaskDetails;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::ConversionTask is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                          $.conversionTaskId    is xml-element    is xml-skip-null                                    is rw; 
  has Str                          $.expirationTime      is xml-element    is xml-skip-null                                    is rw; 
  has ImportInstanceTaskDetails    $.importInstance      is xml-element    is xml-skip-null                                    is rw; 
  has ImportVolumeTaskDetails      $.importVolume        is xml-element    is xml-skip-null                                    is rw; 
  has Str                          $.state               is xml-element    is xml-skip-null                                    is rw;   #=  active | cancelling | cancelled | completed
  has Str                          $.statusMessage       is xml-element    is xml-skip-null                                    is rw; 
  has Tag                          @.tags                is xml-element    is xml-skip-null    is xml-container('tagSet')      is rw; 
}
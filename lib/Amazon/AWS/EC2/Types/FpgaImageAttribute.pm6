use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::LoadPermission;
use Amazon::AWS::EC2::Types::ProductCode;

class Amazon::AWS::EC2::Types::FpgaImageAttribute is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str               $.description        is xml-element                                             is rw; 
  has Str               $.fpgaImageId        is xml-element                                             is rw; 
  has LoadPermission    @.loadPermissions    is xml-element    is xml-container('loadPermissions')      is rw; 
  has Str               $.name               is xml-element                                             is rw; 
  has ProductCode       @.productCodes       is xml-element    is xml-container('productCodes')         is rw; 
}
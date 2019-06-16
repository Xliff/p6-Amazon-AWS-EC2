use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ReservedInstancesId;
use Amazon::AWS::EC2::Types::ReservedInstancesModificationResult;

class Amazon::AWS::EC2::Types::ReservedInstancesModification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                    $.clientToken                        is xml-element    is xml-skip-null                                                   is rw;
  has Str                                    $.createDate                         is xml-element    is xml-skip-null                                                   is rw;
  has Str                                    $.effectiveDate                      is xml-element    is xml-skip-null                                                   is rw;
  has ReservedInstancesModificationResult    @.modificationResults                                  is xml-skip-null    is xml-container('modificationResultSet')      is rw; 
  has Str                                    $.reservedInstancesModificationId    is xml-element    is xml-skip-null                                                   is rw;
  has ReservedInstancesId                    @.reservedInstancess                                   is xml-skip-null    is xml-container('reservedInstancesSet')       is rw;
  has Str                                    $.status                             is xml-element    is xml-skip-null                                                   is rw;
  has Str                                    $.statusMessage                      is xml-element    is xml-skip-null                                                   is rw;
  has Str                                    $.updateDate                         is xml-element    is xml-skip-null                                                   is rw;
}

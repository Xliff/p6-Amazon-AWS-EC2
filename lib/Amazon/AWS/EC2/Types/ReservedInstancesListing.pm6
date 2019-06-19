use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceCount;
use Amazon::AWS::EC2::Types::PriceSchedule;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::ReservedInstancesListing is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str              $.clientToken                   is xml-element    is xml-skip-null                                            is rw; 
  has Str              $.createDate                    is xml-element    is xml-skip-null                                            is rw; 
  has InstanceCount    @.instanceCounts                is xml-element    is xml-skip-null    is xml-container('instanceCounts')      is rw; 
  has PriceSchedule    @.priceSchedules                is xml-element    is xml-skip-null    is xml-container('priceSchedules')      is rw; 
  has Str              $.reservedInstancesId           is xml-element    is xml-skip-null                                            is rw; 
  has Str              $.reservedInstancesListingId    is xml-element    is xml-skip-null                                            is rw; 
  has Str              $.status                        is xml-element    is xml-skip-null                                            is rw;   #=  active | pending | cancelled | closed
  has Str              $.statusMessage                 is xml-element    is xml-skip-null                                            is rw; 
  has Tag              @.tags                          is xml-element    is xml-skip-null    is xml-container('tagSet')              is rw; 
  has Str              $.updateDate                    is xml-element    is xml-skip-null                                            is rw; 
}
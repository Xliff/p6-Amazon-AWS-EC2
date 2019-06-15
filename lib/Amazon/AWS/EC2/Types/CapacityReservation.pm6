use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::CapacityReservation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.availabilityZone          is xml-element    is xml-skip-null                                    is rw; 
  has Int     $.availableInstanceCount    is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.capacityReservationId     is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.createDate                is xml-element    is xml-skip-null                                    is rw; 
  has Bool    $.ebsOptimized              is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.endDate                   is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.endDateType               is xml-element    is xml-skip-null                                    is rw;   #=  unlimited | limited
  has Bool    $.ephemeralStorage          is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.instanceMatchCriteria     is xml-element    is xml-skip-null                                    is rw;   #=  open | targeted
  has Str     $.instancePlatform          is xml-element    is xml-skip-null                                    is rw;   #=  Linux/UNIX | Red Hat Enterprise Linux | SUSE Linux | Windows | Windows with SQL Server | Windows with SQL Server Enterprise | Windows with SQL Server Standard | Windows with SQL Server Web | Linux with SQL Server Standard | Linux with SQL Server Web | Linux with SQL Server Enterprise
  has Str     $.instanceType              is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.state                     is xml-element    is xml-skip-null                                    is rw;   #=  active | expired | cancelled | pending | failed
  has Tag     @.tags                      is xml-element    is xml-skip-null    is xml-container('tagSet')      is rw; 
  has Str     $.tenancy                   is xml-element    is xml-skip-null                                    is rw;   #=  default | dedicated
  has Int     $.totalInstanceCount        is xml-element    is xml-skip-null                                    is rw; 
}
use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchSpecification;
use Amazon::AWS::EC2::Types::SpotInstanceStateFault;
use Amazon::AWS::EC2::Types::SpotInstanceStatus;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::SpotInstanceRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                       $.actualBlockHourlyPrice          is xml-element                                    is rw; 
  has Str                       $.availabilityZoneGroup           is xml-element                                    is rw; 
  has Int                       $.blockDurationMinutes            is xml-element                                    is rw; 
  has Str                       $.createTime                      is xml-element                                    is rw; 
  has SpotInstanceStateFault    $.fault                           is xml-element                                    is rw; 
  has Str                       $.instanceId                      is xml-element                                    is rw; 
  has Str                       $.instanceInterruptionBehavior    is xml-element                                    is rw;   #=  hibernate | stop | terminate
  has Str                       $.launchedAvailabilityZone        is xml-element                                    is rw; 
  has Str                       $.launchGroup                     is xml-element                                    is rw; 
  has LaunchSpecification       $.launchSpecification             is xml-element                                    is rw; 
  has Str                       $.productDescription              is xml-element                                    is rw;   #=  Linux/UNIX | Linux/UNIX (Amazon VPC) | Windows | Windows (Amazon VPC)
  has Str                       $.spotInstanceRequestId           is xml-element                                    is rw; 
  has Str                       $.spotPrice                       is xml-element                                    is rw; 
  has Str                       $.state                           is xml-element                                    is rw;   #=  open | active | closed | cancelled | failed
  has SpotInstanceStatus        $.status                          is xml-element                                    is rw; 
  has Tag                       @.tags                            is xml-element    is xml-container('tagSet')      is rw; 
  has Str                       $.type                            is xml-element                                    is rw;   #=  one-time | persistent
  has Str                       $.validFrom                       is xml-element                                    is rw; 
  has Str                       $.validUntil                      is xml-element                                    is rw; 
}
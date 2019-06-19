use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Filters::DescribeVolumeStatusFilter::Action 
  does XML::Class[xml-element => 'action']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Str $.code        is xml-element is xml-skip-null is rw;
  has Str $.description is xml-element is xml-skip-null is rw;
  has Str $.event-id    is xml-element is xml-skip-null is rw;
}

class Amazon::AWS::EC2::Filters::DescribeVolumeStatusFilter::Event 
  does XML::Class[xml-element => 'event']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.description is xml-element is xml-skip-null is rw;
  has Str $.event-id    is xml-element is xml-skip-null is rw;
  has Str $.event-type  is xml-element is xml-skip-null is rw; #= !! for io-enabled: passed | failed
                                                               #= !! for io-performance: degraded | severely-degraded | stalled
  has Str $.not-after   is xml-element is xml-skip-null is rw;
  has Str $.not-before  is xml-element is xml-skip-null is rw;                                                             
}

class Amazon::AWS::EC2::Filters::DescribeVolumeStatusFilter::VolumeStatus
  does XML::Class[xml-element => 'volume-status']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Str $.details-name    is xml-element is xml-skip-null is rw;  #=  io-enabled | io-performance
  has Str $.details-status  is xml-element is xml-skip-null is rw;  #= !! for io-enabled: passed | failed
                                                                    #= !! for io-performance: normal | degraded | severely-degraded | stalled
  has Str $.status          is xml-element is xml-skip-null is rw;  #= ok | impaired | warning | insufficient-data
}

constant Action       := Amazon::AWS::EC2::Filters::DescribeVolumeStatusFilter::Action;
constant Event        := Amazon::AWS::EC2::Filters::DescribeVolumeStatusFilter::Event;
constant VolumeStatus := Amazon::AWS::EC2::Filters::DescribeVolumeStatusFilter::VolumeStatus;

class Amazon::AWS::EC2::Filters::DescribeVolumeStatusFilter is export 
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Action       $.action                           is xml-skip-null is rw;
  has Str          $.availability-zone is xml-element is xml-skip-null is rw;
  has Event        $.event                            is xml-skip-null is rw;
  has VolumeStatus $.volume-status                    is xml-skip-null is rw;
}

use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::BundleTaskError;
use Amazon::AWS::EC2::Types::Storage;

class Amazon::AWS::EC2::Types::BundleTask is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                $.bundleId      is xml-element          is rw; 
  has BundleTaskError    $.error         is xml-element          is rw; 
  has Str                $.instanceId    is xml-element          is rw; 
  has Str                $.progress      is xml-element          is rw; 
  has Str                $.startTime     is xml-element          is rw; 
  has Str                $.state         is xml-element          is rw;   #=  pending | waiting-for-shutdown | bundling | storing | cancelling | complete | failed
  has Storage            $.storage       is xml-element          is rw; 
  has Str                $.updateTime    is xml-element          is rw; 
}
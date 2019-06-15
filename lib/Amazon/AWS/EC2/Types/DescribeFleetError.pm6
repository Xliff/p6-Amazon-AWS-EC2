use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchTemplateAndOverridesResponse;

class Amazon::AWS::EC2::Types::DescribeFleetError is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                   $.errorCode                     is xml-element    is xml-skip-null          is rw; 
  has Str                                   $.errorMessage                  is xml-element    is xml-skip-null          is rw; 
  has LaunchTemplateAndOverridesResponse    $.launchTemplateAndOverrides    is xml-element    is xml-skip-null          is rw; 
  has Str                                   $.lifecycle                     is xml-element    is xml-skip-null          is rw;   #=  spot | on-demand
}
use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::NatGatewayAddress;
use Amazon::AWS::EC2::Types::ProvisionedBandwidth;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::NatGateway is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                     $.createTime              is xml-element                is xml-skip-null                                                  is rw; 
  has Str                     $.deleteTime              is xml-element                is xml-skip-null                                                  is rw; 
  has Str                     $.failureCode             is xml-element                is xml-skip-null                                                  is rw; 
  has Str                     $.failureMessage          is xml-element                is xml-skip-null                                                  is rw; 
  has NatGatewayAddress       @.natGatewayAddresss                                    is xml-skip-null    is xml-container('natGatewayAddressSet')      is rw;
  has Str                     $.natGatewayId            is xml-element                is xml-skip-null                                                  is rw;
  has ProvisionedBandwidth    $.provisionedBandwidth    is xml-element(:over-ride)    is xml-skip-null                                                  is rw;
  has Str                     $.state                   is xml-element                is xml-skip-null                                                  is rw;   #=  pending | failed | available | deleting | deleted
  has Str                     $.subnetId                is xml-element                is xml-skip-null                                                  is rw;
  has Tag                     @.tags                                                  is xml-skip-null    is xml-container('tagSet')                    is rw;
  has Str                     $.vpcId                   is xml-element                is xml-skip-null                                                  is rw;
}

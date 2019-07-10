use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::PropagatingVgw;
use Amazon::AWS::EC2::Types::Route;
use Amazon::AWS::EC2::Types::RouteTableAssociation;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::RouteTable is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has RouteTableAssociation    @.associations                         is xml-skip-null    is xml-container('associationSet')         is rw; 
  has Str                      $.ownerId            is xml-element    is xml-skip-null                                               is rw; 
  has PropagatingVgw           @.propagatingVgws                      is xml-skip-null    is xml-container('propagatingVgwSet')      is rw; 
  has Route                    @.routes                               is xml-skip-null    is xml-container('routeSet')               is rw; 
  has Str                      $.routeTableId       is xml-element    is xml-skip-null                                               is rw; 
  has Tag                      @.tags                                 is xml-skip-null    is xml-container('tagSet')                 is rw; 
  has Str                      $.vpcId              is xml-element    is xml-skip-null                                               is rw; 
}

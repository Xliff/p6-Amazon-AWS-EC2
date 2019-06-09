use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::RouteTableAssociation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.main                       is xml-element          is rw; 
  has Str     $.routeTableAssociationId    is xml-element          is rw; 
  has Str     $.routeTableId               is xml-element          is rw; 
  has Str     $.subnetId                   is xml-element          is rw; 
}
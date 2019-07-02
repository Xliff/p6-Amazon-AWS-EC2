use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

use Amazon::AWS::EC2::validInstanceTypes;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeHostReservationOfferingsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.instance-family is xml-element is rw;
  has Str $.payment-options is xml-element is rw; #= (NoUpfront | PartialUpfront | AllUpfront
  
  method getInstanceFamilies {
    %attributes<instance-family|ValidValues>.Array;
  }
}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeHostReservationOfferingsFilter
  );
  %attributes<instance-family|ValidValues> = @valid-instance-types.map(
    *.split('.')[0]
  ).Array;
  makeAttributeTable(%attributes, 'instance-family');
}
  

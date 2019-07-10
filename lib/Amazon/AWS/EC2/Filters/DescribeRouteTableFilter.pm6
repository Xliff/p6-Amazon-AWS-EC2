use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Filters::DescribeRouteTableFilter::Association 
  does XML::Class[xml-elements => 'association']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                 $.route-table-association-id                      is xml-skip-null is xml-element is rw;
  has Str                 $.route-table-id                                  is xml-skip-null is xml-element is rw;
  has Str                 $.subnet-id                                       is xml-skip-null is xml-element is rw;
  has Bool                $.main                                            is xml-skip-null is xml-element is rw;
}

class Amazon::AWS::EC2::Filters::DescribeRouteTableFilter::Route is export
  does XML::Class[xml-elements => 'route']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                 $.destination-cidr-block                          is xml-skip-null is xml-element is rw;
  has Str                 $.destination-ipv6-cidr-block                     is xml-skip-null is xml-element is rw;
  has Str                 $.defstination-prefix-list-id                     is xml-skip-null is xml-element is rw;
  has Str                 $.egress-only-internet-gateway-id                 is xml-skip-null is xml-element is rw;
  has Str                 $.gateway-id                                      is xml-skip-null is xml-element is rw;
  has Str                 $.instance-id                                     is xml-skip-null is xml-element is rw;
  has Str                 $.nat-gateway-id                                  is xml-skip-null is xml-element is rw;
  has Str                 $.transit-gateway-id                              is xml-skip-null is xml-element is rw;
  has Str                 $.origin                                          is xml-skip-null is xml-element is rw;  #=  CreateRouteTable | CreateRoute | EnableVgwRoutePropagation
  has Str                 $.state                                           is xml-skip-null is xml-element is rw;  #=  active | blackhole
  has Str                 $.vpc-peering-connection-id                       is xml-skip-null is xml-element is rw;
}


class Amazon::AWS::EC2::Filters::DescribeRouteTableFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                 $.key                                             is xml-skip-null is xml-element is rw;
  has Str                 $.value                                           is xml-skip-null is xml-element is rw;
}

constant Association := Amazon::AWS::EC2::Filters::DescribeRouteTableFilter::Association;
constant Route       := Amazon::AWS::EC2::Filters::DescribeRouteTableFilter::Route;
constant Tag         := Amazon::AWS::EC2::Filters::DescribeRouteTableFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeRouteTableFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Route               $.route                                           is xml-skip-null                is rw;  
  has Association         $.association                                     is xml-skip-null                is rw;  
  has Str                 $.owner-id                                        is xml-skip-null is xml-element is rw;
  has Str                 $.route-table-id                                  is xml-skip-null is xml-element is rw;  
  has Str                 $.vpc-id                                          is xml-skip-null is xml-element is rw;  
  has Str                 $.transit-gateway-id                              is xml-skip-null is xml-element is rw;
  has Tag                 @.tags                is xml-container('tagSet')  is xml-skip-null                is rw;
  has Str                 $.tag-key                                         is xml-skip-null is xml-element is rw;
}

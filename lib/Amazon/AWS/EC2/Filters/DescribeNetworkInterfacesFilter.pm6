use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

use XML::Class;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeNetworkInterfaces::AddressAssociation 
  does XML::Class[xml-element => 'association']
{
  has Str $.owner-id                                               is xml-element is xml-skip-null is rw;
}

constant AddressAssociation := Amazon::AWS::EC2::Filters::DescribeNetworkInterfaces::AddressAssociation;

class Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter::Addresses 
  does XML::Class[xml-element => 'addresses']
{
  has Str                $.private-ip-addresses                    is xml-element is xml-skip-null is rw;
  has Bool               $.primary                                 is xml-element is xml-skip-null is rw;
  has AddressAssociation $.association                                            is xml-skip-null is rw;
}

class Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter::Association
  does XML::Class[xml-element => 'association']
{
  has Str $.association-id                                         is xml-element is xml-skip-null is rw;
  has Str $.allocation-id                                          is xml-element is xml-skip-null is rw;
  has Str $.ip-owner-id                                            is xml-element is xml-skip-null is rw;
  has Str $.public-ip                                              is xml-element is xml-skip-null is rw;
  has Str $.public-dns-name                                        is xml-element is xml-skip-null is rw;
}

class Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter::Attachment
  does XML::Class[xml-element => 'attachment']
{
  has Str $.attachment-id                                          is xml-element is xml-skip-null is rw;
  has Str $.attach-time                                            is xml-element is xml-skip-null is rw;
  has Str $.delete-on-termination                                  is xml-element is xml-skip-null is rw;
  has Str $.device-index                                           is xml-element is xml-skip-null is rw;
  has Str $.instance-id                                            is xml-element is xml-skip-null is rw;
  has Str $.instance-owner-id                                      is xml-element is xml-skip-null is rw;
  has Str $.nat-gateway-id                                         is xml-element is xml-skip-null is rw;
  has Str $.status                                                 is xml-element is xml-skip-null is rw;  #= attaching | attached | detaching | detached
}

class Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter::Ipv6Addresses
  does XML::Class[xml-element => 'ipv6-addresses']
{
  has Str $.ipv6-address                                           is xml-element is xml-skip-null is rw;
}

class Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.key                                                    is xml-element is xml-skip-null is rw;
  has Str $.value                                                  is xml-element is xml-skip-null is rw;
}

constant Addresses   := Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter::Addresses;
constant Association := Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter::Association;
constant Attachment  := Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter::Attachment;
constant Ipv6Address := Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter::Ipv6Addresses;
constant Tag         := Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Addresses   $.addresses                                                     is xml-skip-null is rw;
  has Association $.association                                                   is xml-skip-null is rw;
  has Attachment  $.attachment                                                    is xml-skip-null is rw;
  has Str         $.availability-zone                              is xml-element is xml-skip-null is rw;
  has Str         $.description                                    is xml-element is xml-skip-null is rw;  
  has Str         $.group-id                                       is xml-element is xml-skip-null is rw;
  has Str         $.group-name                                     is xml-element is xml-skip-null is rw;
  has Ipv6Address $.ipv6-addresses                                                is xml-skip-null is rw;
  has Str         $.private-dns-name                               is xml-element is xml-skip-null is rw;
  has Str         $.requester-id                                   is xml-element is xml-skip-null is rw;
  has Str         $.requester-managed                              is xml-element is xml-skip-null is rw;  
  has Bool        $.source-dest-check                              is xml-element is xml-skip-null is rw;  
  has Str         $.status                                         is xml-element is xml-skip-null is rw;  #= availabie | in-use
  has Str         $.subnet-id                                      is xml-element is xml-skip-null is rw;  
  has Tag         @.tags               is xml-container('tagSet')                 is xml-skip-null is rw;
  has Str         $.tag-key                                        is xml-element is xml-skip-null is rw;  
  has Str         $.vpc-id                                         is xml-element is xml-skip-null is rw;
  
  
  # XXX - get/set attribute methods for status
} 

# For direct access to any Attribute metadata.
BEGIN {
  %attributes<DescribeNetworkInterfacesFilter> = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter
  );
  %attributes<Attachment> = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter::Attachment
  );
}

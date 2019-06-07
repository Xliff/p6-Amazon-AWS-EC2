use v6.d;

# Even though in the Amazon::AWS::EC2 namespace, this is not an Amazon::AWS::EC2 Type!

use XML::Class;

class Amazon::AWS::EC2::Filter::BlockDeviceMapping     { ... }
class Amazon::AWS::EC2::Filter::HibernationOptions     { ... }
class Amazon::AWS::EC2::Filter::IamInstanceProfile     { ... }
class Amazon::AWS::EC2::Filter::Instance               { ... }
class Amazon::AWS::EC2::Filter::Ipv6Address            { ... }
class Amazon::AWS::EC2::Filter::NetworkAddrAssociation { ... }
class Amazon::AWS::EC2::Filter::NetworkAddress         { ... }
class Amazon::AWS::EC2::Filter::NetworkAssociation     { ... }
class Amazon::AWS::EC2::Filter::NetworkAttachment      { ... }
class Amazon::AWS::EC2::Filter::NetworkInterface       { ... }
class Amazon::AWS::EC2::Filter::ProductCode            { ... }
class Amazon::AWS::EC2::Filter::Tag                    { ... }

constant BlockDeviceMapping     :=  Amazon::AWS::EC2::Filter::BlockDeviceMapping;
constant HibernationOptions     :=  Amazon::AWS::EC2::Filter::HibernationOptions;
constant IamInstanceProfile     :=  Amazon::AWS::EC2::Filter::IamInstanceProfile;
constant Instance               :=  Amazon::AWS::EC2::Filter::Instance;
constant Ipv6Address            :=  Amazon::AWS::EC2::Filter::Ipv6Address;
constant NetworkAddrAssociation :=  Amazon::AWS::EC2::Filter::NetworkAddrAssociation;
constant NetworkAddress         :=  Amazon::AWS::EC2::Filter::NetworkAddress;
constant NetworkAssociation     :=  Amazon::AWS::EC2::Filter::NetworkAssociation;
constant NetworkAttachment      :=  Amazon::AWS::EC2::Filter::NetworkAttachment;
constant NetworkInterface       :=  Amazon::AWS::EC2::Filter::NetworkInterface;
constant ProductCode            :=  Amazon::AWS::EC2::Filter::ProductCode;
constant Tag                    :=  Amazon::AWS::EC2::Filter::Tag;

class Amazon::AWS::EC2::Filter::BlockDeviceMapping
  does XML::Class[xml-element => 'block-device-mapping']
{
  has Str                       $.attach-time               is xml-element is rw; #= default | host
  has Bool                      $.delete-on-termination     is xml-element is rw; #= i386 | x86_64 | arm64
  has Str                       $.device-name               is xml-element is rw;
  has Str                       $.status                    is xml-element is rw; #= attaching | attached | detaching | detached
  has Str                       $.volume-id                 is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::HibernationOptions
  does XML::Class[xml-element => 'hibernation-options']
{
  has Bool                      $.configured                is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::IamInstanceProfile
  does XML::Class[xml-element => 'iam-instance-profile']
{
  has Str                       $.arn                       is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::Instance
  does XML::Class[xml-element => 'instance']
{
  has Str                       $.group-id                  is xml-element is rw;
  has Str                       $.group-name                is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::Ipv6Address
  does XML::Class[xml-element => 'addresses']
{
  has Str                       $.ipv6-address              is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::NetworkAddrAssociation
  does XML::Class[xml-element => 'association']
{
  has Str                       $.private-ip-address        is xml-element is rw;
  has Str                       $.ip-owner-id               is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::NetworkAddress
  does XML::Class[xml-element => 'address']
{
  has Str                       $.private-ip-address        is xml-element is rw;
  has Bool                      $.primary                   is xml-element is rw;
  has NetworkAddrAssociation    $.association               is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::NetworkAssociation
  does XML::Class[xml-element => 'association']
{
  has Str                       $.public-ip                 is xml-element is rw;
  has Str                       $.ip-owner-id               is xml-element is rw;
  has Str                       $.association-id            is xml-element is rw;
  has Str                       $.attachment-id             is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::NetworkAttachment
  does XML::Class[xml-element => 'attachment']
{
  has Str                       $.attachment-id             is xml-element is rw;
  has Str                       $.instance-id               is xml-element is rw;
  has Str                       $.instance-owner-id         is xml-element is rw;
  has Str                       $.device-id                 is xml-element is rw;
  has Int                       $.device-index              is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::NetworkInterface
  does XML::Class[xml-element => 'network-interface']
{
  has NetworkAddress            $.addresses                                is rw;
  has NetworkAssociation        $.association                              is rw;
  has NetworkAttachment         $.attachment                               is rw;
  has Str                       $.availability-zone         is xml-element is rw;
  has Str                       $.description               is xml-element is rw;
  has Str                       $.group-id                  is xml-element is rw;
  has Str                       $.group-name                is xml-element is rw;
  has Ipv6Address               $.ipv6-addresses                           is rw;
  has Str                       $.mac-address               is xml-element is rw;
  has Str                       $.network-interface-id      is xml-element is rw;
  has Str                       $.owner-id                  is xml-element is rw;
  has Str                       $.private-dns-name          is xml-element is rw;
  has Str                       $.requester-id              is xml-element is rw;
  has Str                       $.requester-managed         is xml-element is rw;
  has Str                       $.status                    is xml-element is rw;
  has Str                       $.source-dest-check         is xml-element is rw;
  has Str                       $.subnet-id                 is xml-element is rw;
  has Str                       $.vpc-id                    is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::ProductCode
  does XML::Class[xml-element => 'product-code']
{
  has Str                       $.type                      is xml-element is rw; #= devpay | marketplace
}

class Amazon::AWS::EC2::Filter::Tag
  does XML::Class[xml-element => 'item']
{
  has Str                       $.key                       is xml-element is rw;
  has Str                       $.value                     is xml-element is rw;
}

# All objects used are local objects. Any EC2 objects used shall be fully qualified.
class Amazon::AWS::EC2::Filter is export
  does XML::Class[xml-element => 'item']
{
  has Str                       $.affinity                  is xml-element is rw;
  has Str                       $.architecture              is xml-element is rw;
  has Str                       $.availability-zone         is xml-element is rw;
  has BlockDeviceMapping        $.block-device-mapping                     is rw;
  has Str                       $.client-token              is xml-element is rw;
  has Str                       $.dns-name                  is xml-element is rw;
  has Str                       $.group-name                is xml-element is rw;
  has HibernationOptions        $.hibernation-options                      is rw;
  has Str                       $.host-id                   is xml-element is rw;
  has Str                       $.hipervisor                is xml-element is rw; #= ovm | xen
  has IamInstanceProfile        $.iam-instance-profile                     is rw;
  has Str                       $.image-id                  is xml-element is rw;
  has Str                       $.instance-id               is xml-element is rw;
  has Str                       $.instance-lifecycle        is xml-element is rw; #= spot | scheduled
  has Int                       $.instance-state-code       is xml-element is rw; #= Low Byte: 0 (pending), 16 (running), 32 (shutting-down), 48 (terminated), 64 (stopping), and 80 (stopped)
  has Str                       $.instance-state-name       is xml-element is rw; #= pending | running | shutting-down | terminated | stopping | stopped
  has Str                       $.instance-type             is xml-element is rw; # See Amazon::AWS::EC2::validInstanceTypes;
  has Instance                  $.instance                                 is rw;
  has Str                       $.ip-address                is xml-element is rw;
  has Str                       $.kernel-id                 is xml-element is rw;
  has Str                       $.key-name                  is xml-element is rw;
  has Int                       $.launch-index              is xml-element is rw;
  has Str                       $.launch-time               is xml-element is rw;
  has Str                       $.monitoring-state          is xml-element is rw;
  has NetworkInterface          $.network-interface         is xml-element is rw;
  has Str                       $.owner-id                  is xml-element is rw;
  has Str                       $.placement-group-name      is xml-element is rw;
  has Str                       $.private-dns-name          is xml-element is rw;
  has Str                       $.private-ip-address        is xml-element is rw;
  has Str                       $.ami-product-code          is xml-element is rw; #= Filter.product-code -- Renamed due to conflict with $.product-code field.
  has ProductCode               $.product-code              is xml-element is rw;
  has Str                       $.ramdisk-id                is xml-element is rw;
  has Str                       $.reason                    is xml-element is rw;
  has Str                       $.requester-id              is xml-element is rw;
  has Str                       $.reservation-id            is xml-element is rw;
  has Str                       $.root-device-name          is xml-element is rw;
  has Str                       $.root-device-type          is xml-element is rw; #= ebs | instance-store
  has Str                       $.source-dest-check         is xml-element is rw;
  has Str                       $.spot-instance-request-id  is xml-element is rw;
  has Str                       $.state-reason-code         is xml-element is rw;
  has Str                       $.state-reason-message      is xml-element is rw;
  has Str                       $.subnet-id                 is xml-element is rw;

  # For serialization, the XML representation is wildly different than how it
  # will be emitted to the request. See the attributes attached description.
  has Tag                       @.tags
                                is xml-container('tags')                   is rw; #= The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key Owner and the value TeamA, specify tag:Owner for the filter name and TeamA for the filter value.

  has Str                       $.tag-key                   is xml-element is rw;
  has Str                       $.tenancy                   is xml-element is rw; #= dedicated | default | host
  has Str                       $.virtualization-type       is xml-element is rw; #= paravirtual | hvm
  has Str                       $.vpc-id                    is xml-element is rw;
}

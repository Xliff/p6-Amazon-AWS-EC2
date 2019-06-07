use v6.d;

use Amazon::AWS::EC2::Base;

class Amazon::AWS::EC2::Filter::BlockDeviceMapping {
  has Str                $.attach-time               is xml-element is rw; #= default | host
  has Bool               $.delete-on-termination     is xml-element is rw; #= i386 | x86_64 | arm64
  has Str                $.device-name               is xml-element is rw;
  has Str                $.status                    is xml-element is rw; #= attaching | attached | detaching | detached
  has Str                $.volume-id                 is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::HibernationOptions {
  has Bool               $.configured                is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::IamInstanceProfile {
  has Str                $.arn                       is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::Instance {
  has Str                $.group-id                  is xml-element is rw;
  has Str                $.group-name                is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::Ipv6Address {
  has Str                $.ipv6-address              is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::NetworkInterface {
  has NetworkAddress     $.addresses                                is rw;
  has NetworkAssociation $.association                              is rw;
  has NetworkAttachment  $.attachment                               is rw;
  has Str                $.availability-zone         is xml-element is rw;
  has Str                $.description               is xml-element is rw;
  has Str                $.group-id                  is xml-element is rw;
  has Str                $.group-name                is xml-element is rw;
  has Ipv6Address        $.addresses                                is rw;
  has Str                $.mac-address               is xml-element is rw;
  has Str                $.network-interface-id      is xml-element is rw;
  has Str                $.owner-id                  is xml-element is rw;
  has Str                $.private-dns-name          is xml-element is rw;
  has Str                $.requester-id              is xml-element is rw;
  has Str                $.requester-managed         is xml-element is rw;
  has Str                $.status                    is xml-element is rw;
  has Str                $.source-dest-check         is xml-element is rw;
  has Str                $.subnet-id                 is xml-element is rw;
  has Str                $.vpc-id                    is xml-element is rw;
}

class Amazon::AWS::EC2::Filter::ProductCode {
  has Str $.type is xml-element is rw; #= devpay | marketplace
}

class Amazon::AWS::EC2::Filter::Tag {
  has Str $.key is rw;
  has Str $.value is xml-element is rw;
}

class Amazon::AWS::EC2::Filter is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon:AWS::EC2::Base;

  has Str                $.affinity                  is xml-element is rw;
  has Str                $.architecture              is xml-element is rw;
  has Str                $.availability-zone         is xml-element is rw;
  has BlockDeviceMapping $.block-device-mapping                     is rw;
  has Str                $.client-token              is xml-element is rw;
  has Str                $.dns-name                  is xml-element is rw;
  has Str                $.group-name                is xml-element is rw;
  has HibernationOptions $.hibernation-options                      is rw;
  has Str                $.host-id                   is xml-element is rw;
  has Str                $.hipervisor                is xml-element is rw; #= ovm | xen
  has IamInstanceProfile $.iam-instance-profile                     is rw;
  has Str                $.image-id                  is xml-element is rw;
  has Str                $.instance-id               is xml-element is rw;
  has Str                $.instance-lifecycle        is xml-element is rw; #= spot | scheduled
  has Int                $.instance-state-code       is xml-element is rw; #= Low Byte: 0 (pending), 16 (running), 32 (shutting-down), 48 (terminated), 64 (stopping), and 80 (stopped)
  has Str                $.instance-state-name       is xml-element is rw; #= pending | running | shutting-down | terminated | stopping | stopped
  has Str                $.instance-type             is xml-element is rw; # See Amazon::AWS::EC2::validInstanceTypes;
  has Instance           $.instance                                 is rw;
  has Str                $.ip-address                is xml-element is rw;
  has Str                $.kernel-id                 is xml-element is rw;
  has Str                $.key-name                  is xml-element is rw;
  has Int                $.launch-index              is xml-element is rw;
  has Str                $.launch-time               is xml-element is rw;
  has Str                $.monitoring-state          is xml-element is rw;
  has NetworkInterface   $.network-interface         is xml-element is rw;
  has Str                $.owner-id                  is xml-element is rw;
  has Str                $.placement-group-name      is xml-element is rw;
  has Str                $.private-dns-name          is xml-element is rw;
  has Str                $.private-ip-address        is xml-element is rw;
  has Str                $.ami-product-code          is xml-element is rw; #= Filter.product-code -- Renamed due to conflict with $.product-code field.
  has ProductCode        $.product-code              is xml-element is rw;
  has Str                $.ramdisk-id                is xml-element is rw;
  has Str                $.reason                    is xml-element is rw;
  has Str                $.requester-id              is xml-element is rw;
  has Str                $.reservation-id            is xml-element is rw;
  has Str                $.root-device-name          is xml-element is rw;
  has Str                $.root-device-type          is xml-element is rw; #= ebs | instance-store
  has Str                $.source-dest-check         is xml-element is rw;
  has Str                $.spot-instance-request-id  is xml-element is rw;
  has Str                $.state-reason-code         is xml-element is rw;
  has Str                $.state-reason-message      is xml-element is rw;
  has Str                $.subnet-id                 is xml-element is rw;

  # For serialization, the XML representation is wildly different than how it
  # will be emitted to the request. See the attributes attached description.
  has Tag                @.tags
                         is xml-container('tags')                   is rw; #= The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key Owner and the value TeamA, specify tag:Owner for the filter name and TeamA for the filter value.

  has Str $.tag-key                                  is xml-element is rw;
  has Str $.tenancy                                  is xml-element is rw; #= dedicated | default | host
  has Str $.virtualization-type                      is xml-element is rw; #= paravirtual | hvm
  has Str $.vpc-id                                   is xml-element is rw;
}

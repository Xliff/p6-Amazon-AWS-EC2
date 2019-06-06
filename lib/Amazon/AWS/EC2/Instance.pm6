use v6.d;

use XML::Class  ;

use Amazon::AWS::EC2::CapacityReservationSpecification;
use Amazon::AWS::EC2::CpuOptions;
use Amazon::AWS::EC2::ElasticGpuAssociation;
use Amazon::AWS::EC2::ElasticInferenceAcceleratorAssociation;
use Amazon::AWS::EC2::GroupIdentifier;
use Amazon::AWS::EC2::HibernationOptions;
use Amazon::AWS::EC2::IamInstanceProfile;
use Amazon::AWS::EC2::InstanceBlockDeviceMapping;
use Amazon::AWS::EC2::InstanceNetworkInterface;
use Amazon::AWS::EC2::InstanceState;
use Amazon::AWS::EC2::LicenseConfiguration;
use Amazon::AWS::EC2::Placement;
use Amazon::AWS::EC2::ProductCode;
use Amazon::AWS::EC2::StateReason;
use Amazon::AWS::EC2::Tag;


my (@valid-instance-types, $valid-types);
BEGIN {
  @valid-instance-types = <
  t1.micro
  t2.nano   t2.micro  t2.small  t2.medium   t2.large     t2.xlarge    t2.2xlarge
  t3.nano   t3.micro  t3.small  t3.medium   t3.large     t3.xlarge    t3.2xlarge
  t3a.nano  t3a.micro t3a.small t3a.medium  t3a.large    t3a.xlarge   t3a.2xlarge
                      m1.small  m1.medium   m1.large     m1.xlarge
                                m3.medium   m3.large     m3.xlarge    m3.2xlarge
                                            m4.large     m4.xlarge    m4.2xlarge     m4.4xlarge                                   m4.10xlarge                    m4.16xlarge
                                                         m2.xlarge    m2.2xlarge     m2.4xlarge
                                                                                                     r1.8xlarge
                                            r3.large     r3.xlarge    r3.2xlarge     r3.4xlarge      r3.8xlarge
                                            r4.large     r4.xlarge    r4.2xlarge     r4.4xlarge      r4.8xlarge                                                  r4.16xlarge
                                            r5.large     r5.xlarge    r5.2xlarge     r5.4xlarge                                                 r5.12xlarge                                      r5.24xlarge                         r5.metal
                                            5a.large     r5a.xlarge   5a.2xlarge     r5a.4xlarge                                                r5a.12xlarge                                     r5a.24xlarge
                                            r5d.large    r5d.xlarge   r5d.2xlarge    r5d.4xlarge                                                r5d.12xlarge                                     r5d.24xlarge                        r5d.metal
                                            r5ad.large   r5ad.xlarge  r5ad.2xlarge   r5ad.4xlarge    r5ad.8xlarge                               r5ad.12xlarge    r5ad.16xlarge                   r5ad.24xlarge
                                                                                                                                                                 x1.16xlarge                                        x1.32xlarge
                                                         x1e.xlarge   x1e.2xlarge    x1e.4xlarge     x1e.8xlarge                                                 x1e.16xlarge                                       x1e.32xlarge
                                                         i2.xlarge    i2.2xlarge     i2.4xlarge      i2.8xlarge
                                            i3.large     i3.xlarge    i3.2xlarge     i3.4xlarge      i3.8xlarge                                                  i3.16xlarge                                                         i3.metal
                                                                                     hi1.4xlarge     hs1.8xlarge
                                c1.medium                c1.xlarge
                                            c3.large     c3.xlarge    c3.2xlarge     c3.4xlarge      c3.8xlarge
                                            c4.large     c4.xlarge    c4.2xlarge     c4.4xlarge      c4.8xlarge
                                            c5.large     c5.xlarge    c5.2xlarge     c5.4xlarge                     c5.9xlarge                                                    c5.18xlarge
                                            c5d.large    c5d.xlarge   c5d.2xlarge    c5d.4xlarge                    c5d.9xlarge                                                   c5d.18xlarge
                                            c5n.large    c5n.xlarge   c5n.2xlarge    c5n.4xlarge                    c5n.9xlarge                                                   c5n.18xlarge
                                                                                     cc1.4xlarge     cc2.8xlarge
                                                                      g2.2xlarge                     g2.8xlarge
                                                                                     g3.4xlarge      g3.8xlarge                                                  g3.16xlarge
                                                         g3s.xlarge                  cg1.4xlarge
                                                         p2.xlarge                                   p2.8xlarge                                                  p2.16xlarge
                                                                      p3.2xlarge                     p3.8xlarge                                                  p3.16xlarge
                                                                                                                                                                                                 p3dn.24xlarge
                                            d2.xlarge    d2.2xlarge   d2.4xlarge                     d2.8xlarge
                                                         f1.2xlarge   f1.4xlarge                                                                                 f1.16xlarge
                                            m5.large
                                            m5.xlarge    m5.2xlarge   m5.4xlarge                                                                m5.12xlarge                                      m5.24xlarge                           m5.metal
                                            m5a.large    m5a.xlarge   m5a.2xlarge    m5a.4xlarge                                                m5a.12xlarge                                     m5a.24xlarge
                                            m5d.large    m5d.xlarge   m5d.2xlarge    m5d.4xlarge                                                m5d.12xlarge                                     m5d.24xlarge                          m5d.metal
                                            m5ad.large   m5ad.xlarge  m5ad.2xlarge   m5ad.4xlarge    m5ad.8xlarge                               m5ad.12xlarge    m5ad.16xlarge                   m5ad.24xlarge
                                                                      h1.2xlarge     h1.4xlarge      h1.8xlarge                                                  h1.16xlarge
                                            z1d.large    z1d.xlarge   z1d.2xlarge    z1d.3xlarge     z1d.6xlarge                                z1d.12xlarge                                                                           z1d.metal
                                                                                                                                                                                                                                       u-6tb1.metal
                                                                                                                                                                                                                                       u-9tb1.metal
                                                                                                                                                                                                                                       u-12tb1.metal
                                a1.medium   a1.large     a1.xlarge    a1.2xlarge     a1.4xlarge
>;
  my $col-length = @valid-instance-types.map( *.chars ).max + 4;
  my $num-cols = 72 / $col-length;
  my @types = do gather for @valid-instance-types.batch($num-cols.Int) {
    take "\t{ .Array.map( *.fmt("%-{$col-length}s").join('') ) }"
  }
  $valid-types = @types.join("\n");
}

class Amazon::AWS::EC2::Instance is export
  does XML::Class[xml-element => 'item'] 
{
  has Int                              $.amiLaunchIndex                   is xml-element is rw;
  has Str                              $.architecture                     is xml-element is rw;
  has Str                              $.capacityReservationId            is xml-element is rw;
  has CapacityReservationSpecification $.capacityReservationSpecification                is rw;
  has Str                              $.clientToken                      is xml-element is rw;
  has CpuOptions                       $.cpuOptions                                      is rw;
  has Str                              $.dnsName                          is xml-element is rw;
  has Bool                             $.ebsOptimized                     is xml-element is rw;
  has Bool                             $.enaSupport                       is xml-element is rw;
  has HibernationOptions               $.hibernationOptions                              is rw;
  has Str                              $.hypervisor                       is xml-element is rw;
  has IamInstanceProfile               $.iamInstanceProfile                              is rw;
  has Str                              $.imageId                          is xml-element is rw;
  has Str                              $.instanceLivecycle                is xml-element is rw;
  has InstanceState                    $.instanceState                                   is rw;
  has Str                              $.instanceType                     is xml-element is rw;
  has Str                              $.ipAddress                        is xml-element is rw;
  has Str                              $.kernelId                         is xml-element is rw;
  has Str                              $.keyName                          is xml-element is rw;
  has Placement                        $.placement                                       is rw;
  has Str                              $.platform                         is xml-element is rw;
  has Str                              $.privateDnsName                   is xml-element is rw;
  has Str                              $.ramdiskId                        is xml-element is rw;
  has Str                              $.reason                           is xml-element is rw;
  has Str                              $.rootDeviceName                   is xml-element is rw;
  has Str                              $.rootDeviceType                   is xml-element is rw;
  has Bool                             $.sourceDestCheck                  is xml-element is rw;
  has Str                              $.spotInstanceRequestId            is xml-element is rw;
  has Str                              $.sirovNetSupport                  is xml-element is rw;
  has StateReason                      $.stateReason                                     is rw;
  has Str                              $.subnetId                         is xml-element is rw;
  has Str                              $.vpcId                            is xml-element is rw;

  has GroupIdentifier                         @.groups
    is xml-container('groupSet')                                 ;
  has InstanceBlockDeviceMapping              @.block-mappings
    is xml-container('blockDeviceMapping')                       ;
  has ElasticGpuAssociation                   @.elasticGpuAssociations
    is xml-container('elasticGpuAssociaionSet')                  ;
  has ElasticInferenceAcceleratorAssociation  @.elasticInferenceAccelatorAssociations
    is xml-container('elasticInferenceAcceleratorAssociationSet');
  has LicenseConfiguration                    @.licenses
    is xml-container('licenseSet')                               ;
  has InstanceNetworkInterface                @.networkInterfaces
    is xml-container('networkInterfaceSet')                      ;
  has ProductCode                             @.productCodes
    is xml-container('productCodes')                             ;
  has Tag                                     @.tags
    is xml-container('tagSet')                                   ;

  # Throw a typed exception with a message payload!
  method setInstanceType($type) {
    die "Invalid instance type '{$type}'. Valid instance types are:\n{
        $valid-types }"
    unless $type eq @valid-instance-types.any;
    $!instanceType = $type;
  }

}

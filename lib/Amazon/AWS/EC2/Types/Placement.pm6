use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::Placement is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  # Request
  has Str $.Affinity         is xml-element is xml-skip-null is rw;
  has Str $.AvailabilityZone is xml-element is xml-skip-null is rw;
  has Str $.GroupName        is xml-element is xml-skip-null is rw;
  has Str $.HostId           is xml-element is xml-skip-null is rw;
  has Str $.PartitionNumber  is xml-element is xml-skip-null is rw;
  has Str $.SpreadDomain     is xml-element is xml-skip-null is rw;
  has Str $.Tenancy          is xml-element is xml-skip-null is rw;

  # Response
  has Str $.affinity         is xml-element is xml-skip-null is rw;
  has Str $.availabilityZone is xml-element is xml-skip-null is rw;
  has Str $.groupName        is xml-element is xml-skip-null is rw;
  has Str $.hostId           is xml-element is xml-skip-null is rw;
  has Str $.partitionNumber  is xml-element is xml-skip-null is rw;
  has Str $.spreadDomain     is xml-element is xml-skip-null is rw;
  has Str $.tenancy          is xml-element is xml-skip-null is rw;

  method setTenancy($val) {
    my @valid-values = <default dedicated host>;

    die "Invalid tenancy value '{$val}'. Valid options are {
         @valid-values.join(', ')}"
    unless $val ~~ @valid-values.any;
    $!Tenancy = $val;
  }

}

use v6.d;

unit package Amazon::AWS::EC2::validResourceIds;

our %validIdTypes = (
  acl      => 'Network ACL',
  aclassoc => 'ACL Association',
  arn      => 'Amazon Resource Name',
  dopt     => 'DHCP Options Set',
  eipalloc => 'Elastic IP Allocation',
  eni      => 'Elastic Network Interface',
  hro      => 'Host Reservation Offering',
  i        => 'Instance',
  lt       => 'Launch Template',
  nat      => 'NAT Gateway',
  pl       => 'Prefix List',
  policy   => 'Snapshot Lifecycle Policy',
  rtb      => 'Route Table',
  rtbassoc => 'Route Table Association',
  snap     => 'Snapshot',
  'sub'    => 'Subnet',
  tmf      => 'Traffic Mirror Filter',
  tmt      => 'Traffic Mirror Target',
  vol      => 'Volume',
  vpc      => 'VPC',
  vpce     => 'VPC Endpoint',
  vpce-nfn => 'VPC Endpoint Notification'
);

sub getIdType($id) {  
  for %validIdTypes.pairs {
    next unless $id.starts-with(.key);
    # Capture left for future use.
    next unless $id.lc ~~ /'-' ( [ <xdigit> ** 8 | <xdigit> ** 17 ] ) $/;
    return .value;
  }
  False;
}
      
    

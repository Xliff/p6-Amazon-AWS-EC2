use v6.d;

unit package Amazon::AWS::EC2::validResourceIds;

our %validIdTypes = (
  eni      => 'Elastic Network Interface',
  i        => 'Instance',
  vol      => 'Volume',
  'sub'    => 'Subnet',
  vpc      => 'VPC',
  vpce     => 'VPC Endpoint',
  snap     => 'Snapshot',
  eipalloc => 'Elastic IP Allocation',
  policy   => 'Snapshot Lifecycle Policy',
  arn      => 'Amazon Resource Name',
  hro      => 'Host Reservation Offering',
  aclassoc => 'ACL Association',
  acl      => 'Network ACL',
  pl       => 'Prefix List',
  rtb      => 'Route Table',
  rtbassoc => 'Route Table Association',
  nat      => 'NAT Gateway',
  dopt     => 'DHCP Options Set'
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
      
    

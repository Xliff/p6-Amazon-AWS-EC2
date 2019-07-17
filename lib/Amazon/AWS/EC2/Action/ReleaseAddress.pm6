use v6.d;

use Method::Also;

use Amazon::AWS::Utils;

use XML::Class;

use Amazon::AWS::EC2::Response::ReleaseAddressResponse;

class Amazon::AWS::EC2::Action::ReleaseAddress is export
  does XML::Class[xml-element => 'ReleaseAddress']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];
  
  has Str  $.AllocationId  is xml-element is xml-skip-null is rw;
  has Bool $.DryRun        is xml-element is xml-skip-null is rw;
  has Str  $.PublicIp      is xml-element is xml-skip-null is rw;
  
  submethod BUILD (
    :$allocationId,
    :$dryRun,
    :$publicIp,
    # For deserialization purposes, only!
    :$!AllocationId  = '',
    :$!DryRun        = False,
    :$!PublicIp      = ''
  ) { 
    my $a = ($allocationId // '').trim;
    my $p = ($publicIp // '').trim;
    
    $!DryRun       = $dryRun if $dryRun;
    $!AllocationId = $a      if $a.chars;      
    $!PublicIp     = $p      if $p.chars;
  }
  
  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die 'You may specify public IP or allocation ID, but not both in the same call'
      if $!AllocationId.chars && $!PublicIp.chars;
    die 'You must specify one of public IP or allocation ID!'
      unless $!AllocationId.chars || $PublicIp.chars;
      
    # @Args must be sorted by key name.
    my @args; 
    @args.push: (AllocationId   => $!AllocationId)  if $!AllocationId.chars;
    @args.push: (DryRun         => $!DryRun);    
    @args.push: (PublicIp       => $!PublicIp)      if $!PublicIp.chars;
    @args.push: (Version        => '2016-11-15');

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }

}

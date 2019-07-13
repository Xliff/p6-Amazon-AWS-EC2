use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::AllocateAddressResponse;

my %attributes;

class Amazon::AWS::EC2::Action::AllocateAddress is export
  does XML::Class[xml-element => 'AllocateAddress']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];
  
  has Str  $.Address        is xml-element is xml-skip-null is rw;
  has Str  $.Domain         is xml-element is xml-skip-null is rw;  #= vpc | standard
  has Bool $.DryRun         is xml-element is xml-skip-null is rw;
  has Str  $.PublicIpv4Pool is xml-element is xml-skip-null is rw;
  
  submethod BUILD (
    :$address,
    :$domain,
    :$dryRun,
    :$publicIpv4Pool,
    # For deserialization purposes, only!
    :$!Address        = '',
    :$!Domain         = '',
    :$!DryRun         = False,
    :$!PublicIpv4Pool = ''
  ) { 
    $!DryRun = $dryRun if $dryRun;
    
    $!Address = $address        
      if $address.defined && $address.chars;
      
    $!Domain = $domain         
      if $domain.defined && $domain.chars;
      
    $!PublicIpv4Pool = $publicIpv4Pool 
      if $publicIpv4Pool.defined && $publicIpv4Pool.chars;
  }
  
  method run (:$raw)
    is also<
      do
      execute
    >
  {
    # @Args must be sorted by key name.
    my @args; 
    @args.push: (Domain         => $.Domain)         if $.Domain.chars;
    @args.push: (Address        => $.Address)        if $.Address.chars;
    @args.push: (DryRun         => $.DryRun);
    @args.push: (PublicIpv4Pool => $.PublicIpv4Pool) if $.PublicIpv4Pool.chars;
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
  
  method getValidDomains {
    %attributes<Domain|ValidValues>.Array;
  }
   
}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::AllocateAddress
  );
}

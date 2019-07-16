use v6.c;

use Method::Also;

use XML::Class;

use Amazon::AWS::EC2::Response::CreateVpcResponse;
use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Action::CreateVpc is export
  does XML::Class[
    xml-element   => 'CreateVpc',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool $.AmazonProvidedIpv6CidrBlock is xml-element is xml-skip-null is rw;
  has Str  $.CidrBlock                   is xml-element is xml-skip-null is rw;
  has Bool $.DryRun                      is xml-element is xml-skip-null is rw;
  has Str  $.InstanceTenacy              is xml-element is xml-skip-null is rw;   # = default | dedicated | host 

  submethod BUILD (
    :$amazonProvidedIpv6CidrBlock,
    :$cidrBlock,
    :$dryRun,
    :$instanceTenacy,
    # For deserialization purposes, only!
    :$!AmazonProvidedIpv6CidrBlock = False,
    :$!DryRun                      = False,
    :$!CidrBlock                   = '',
    :$!InstanceTenacy              = ''
  ) { 
    $!AmazonProvidedIpv6CidrBlock = $amazonProvidedIpv6CidrBlock 
                                       if $amazonProvidedIpv6CidrBlock;
    $!DryRun         = $dryRun         if $dryRun;
    $!CidrBlock      = $cidrBlock      if $cidrBlock.defined;
    $!InstanceTenacy = $instanceTenacy if $instanceTenacy.defined;
    
    my $dieMsg = qq:to/DIE/;
    InstanceTenacy value is invalid, you must use one of the following values:
    { %attributes<InstanceTenacy|ValidValues> }
    DIE
    
    die $dieMsg 
      unless $!InstanceTenacy.chars || 
             $!InstanceTenacy ~~ %attributes<InstanceTenacy|ValidValues>.any
      
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die 'CidrBlock is required!' 
      unless $!CidrBlock.defined && $!CidrBlock.chars;
      
    my $dieMsg = qq:to/DIE/;
    CidrBlock is invalid. Please specify a valid tenacy cidr specification.
    Note that the largest block you can request is a /16, and the smallest, 
    a /28.
    DIE
    
    die $dieMsg unless $!CidrBlock ~~ / '/' (\d ** 2) $/;
    die $dieMsg unless $/[0].Int ~~ 16..28;
    
    # Added due to comment on documentation page, located here: 
    # https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVpc.html
    die '"host" value currently not allowed for InstanceTenacy'
      if $!InstanceTenacy eq 'host'
    
    # Should already be sorted.
    my @args = (
      AmazonProvidedIpv6CidrBlock => urlEncode($!AmazonProvidedIpv6CidrBlock),
      CidrBlock                   => urlEncode($!CidrBlock),
      DryRun                      => $.DryRun
    );
    @args.push:  (InstanceTenacy  => $!InstanceTenacy)
      if $!InstanceTenacy.chars;
    @args.push:  (Version         => '2016-11-15');

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }
  
  method getValidInstanceTenacyValues 
    is also<
      getValidTenacyValues
      getTenacyValues
    >
  {
    %attributes<InstanceTenacy|ValidValues>.Array;
  }  

}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::CreateVpc
  );
}

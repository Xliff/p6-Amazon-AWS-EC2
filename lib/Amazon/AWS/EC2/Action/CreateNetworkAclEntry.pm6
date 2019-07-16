use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;

use Amazon::AWS::EC2::Response::CreateNetworkAclEntryResponse;

use Amazon::AWS::EC2::Types::IcmpTypeCode;
use Amazon::AWS::EC2::Types::PortRange;

my %attributes;

class Amazon::AWS::EC2::Action::CreateNetworkAclEntry is export
  does XML::Class[xml-element => 'CreateNetworkAclEntry']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];
  
  has Str           $.CidrBlock       is xml-element              is xml-skip-null is rw;
  has Bool          $.DryRun          is xml-element              is xml-skip-null is rw;
  has Bool          $.Egress          is xml-element              is xml-skip-null is rw;
  has IcmpTypeCode  $.Icmp            is xml-element(:over-ride)  is xml-skip-null is rw;
  has Str           $.Ipv6CidrBlock   is xml-element              is xml-skip-null is rw;
  has Str           $.NetworkAclId    is xml-element              is xml-skip-null is rw;
  has PortRange     $.PortRange       is xml-element(:over-ride)  is xml-skip-null is rw;
  has Str           $.Protocol        is xml-element              is xml-skip-null is rw;
  has Str           $.RuleAction      is xml-element              is xml-skip-null is rw;  #=  allow | deny
  has Int           $.RuleNumber      is xml-element              is xml-skip-null is rw;
  
  submethod BUILD (
    :$cidrBlock,
    :$dryRun,
    :$egress,
    :$icmp,
    :$ipv6CidrBlock,
    :$networkAclId,
    :$portRange,
    :$protocol,
    :$ruleAction,
    :$ruleNumber,
    # For deserialization purposes, only!
    :$!CidrBlock     = '',
    :$!DryRun        = False,
    :$!Egress        = False,
    :$!Icmp          = IcmpTypeCode,
    :$!Ipv6CidrBlock = '',
    :$!NetworkAclId  = '',
    :$!PortRange     = PortRange,
    :$!Protocol      = '',
    :$!RuleAction    = '',
    :$!RuleNumber    = 0,
  ) { 
    $!DryRun           = $dryRun        if $dryRun;
    $!Egress           = $egress        if $egress;
    $!Icmp             = $icmp          if $icmp.defined;
    $!PortRange        = $portRange     if $portRange.defined;
    $!Protocol         = $protocol.Str  if $protocol.defined;
    $!RuleNumber       = $ruleNumber    if $ruleNumber.defined;
    
    $!CidrBlock        = $cidrBlock   
      if $cidrBlock.defined     && $cidrBlock.trim.chars;
    $!Ipv6CidrBlock    = $ipv6CidrBlock 
      if $ipv6CidrBlock.defined && $ipv6CidrBlock.trim.chars;
    $!NetworkAclId     = $networkAclId  
      if $networkAclId.defined  && $networkAclId.trim.chars;
    $!RuleAction       = $ruleAction    
      if $ruleAction.defined    && $ruleAction.trim.chars;
      
    my $dieMsg = qq:to/DIE/;
    Invalid Interface type passed! Should be one of:
    { %attributes<RuleAction|Table> }
    DIE
    
    die $dieMsg unless $!RuleAction.chars == 0 || 
                       $!RuleAction ~~ self.getValidRuleActions.any;
  }
  
  method run (:$raw)
    is also<
      do
      execute
    >
  {
    # Based on error message encountered during run testing:
    # Additional Error Message(s):
    # - The request must contain the parameter cidrBlock or ipv6CidrBlock (MissingParameter)
    # This contradicts (and overrides) the decription found here:
    # https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateNetworkAclEntry.html
    die 'CidrBlock must be declared!' unless $!CidrBlock.chars;
    
    # @Args must be sorted by key name.
    my @args = (
                 DryRun           => $!DryRun,
                 CidrBlock        => urlEncode($!CidrBlock),
                 Egress           => $!Egress
    );
    
    if $!Icmp.defined {
      # All Int, so does not need encoding.
      @args.push: Pair.new("Icmp.{.key}", .value) for $!Icmp.pairs;
    }
    
    @args.push: (Ipv6CidrBlock    => urlEncode($!Ipv6CidrBlock)
      if $!Ipv6CidrBlock.chars;
    @args.push: (NetworkAclId     => $!NetworkAclId if $!NetworkAclId.chars;
    
    if $!PortRange.defined {
      @args.push: Pair.new("PortRange.{.key}", urlEncode(.value)) 
        for $!PortRange.pairs;
    }
    
    @args.push: (Protocol         => $.Protocol)    if $!Protocol.chars;
    @args.push: (RuleAction       => $.RuleAction)  if $!RuleAction.chars;
    @args.push: (RuleNumber       => $.RuleNumber)  if $!RuleNumber;      
    @args.push: (Version          => '2016-11-15');

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }
  
  method getValidRuleActions {
    %attributes<RuleAction|ValidValues>.Array;
  }
   
}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::CreateNetworkAclEntry
  );
}

use v6.d;

use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use XML::Class;

use Amazon::AWS::EC2::Types::IpPermission;
use Amazon::AWS::EC2::Response::AuthorizeSecurityGroupIngressResponse;

class Amazon::AWS::EC2::AuthorizeSecurityGroupIngress is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^shortname;

  has Str             $.CidrIp                        is xml-element                        is xml-skip-null                                               is rw;
  has Bool            $.DryRun                        is xml-element                        is xml-skip-null                                               is rw;
  has Int             $.FromPort                      is xml-element                        is xml-skip-null                                               is rw;
  has Str             $.GroupId                       is xml-element                        is xml-skip-null                                               is rw;
  has Str             $.GroupName                     is xml-element                        is xml-skip-null                                               is rw;
  has IpPermission    @.IpPermissions                 is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('ipPermissionssSet')      is rw;
  has Str             $.IpProtocol                    is xml-element                        is xml-skip-null                                               is rw;
  has Str             $.SourceSecurityGroupName       is xml-element                        is xml-skip-null                                               is rw;
  has Str             $.SourceSecurityGroupOwnerId    is xml-element                        is xml-skip-null                                               is rw;
  has Int             $.ToPort                        is xml-element                        is xml-skip-null                                               is rw;

  submethod BUILD (
    :$cidrIp                      ,
    :$dryRun                      ,
    :$fromPort                    ,
    :$groupId                     ,
    :$groupName                   ,
    :@ipPermissions               ,
    :$ipProtocol                  ,
    :$sourceSecurityGroupName     ,
    :$sourceSecurityGroupOwnerId  ,
    :$toPort                      ,
    :$!CidrIp                     = '',
    :$!DryRun                     = False,
    :$!FromPort                   = Int,
    :$!GroupId                    = '',
    :$!GroupName                  = '',
    :@!IpPermissions              ,
    :$!IpProtocol                 = '',
    :$!SourceSecurityGroupName    = '',
    :$!SourceSecurityGroupOwnerId = '',
    :$!ToPort                     = Int
  ) {
    $!CidrIp                       = $cidrIp                      if $cidrIp   ;
    $!DryRun                       = $dryRun                      if $dryRun   ;
    $!FromPort                     = $fromPort                    if $fromPort ;
    $!GroupId                      = $groupId                     if $groupId  ;
    $!GroupName                    = $groupName                   if $groupName;
    $!IpProtocol                   = $ipProtocol
      if $ipProtocol;
    $!SourceSecurityGroupName      = $sourceSecurityGroupName
      if $sourceSecurityGroupName;
    $!SourceSecurityGroupOwnerId   = $sourceSecurityGroupOwnerId
      if $sourceSecurityGroupOwnerId;
    $!ToPort                       = $toPort                      if $toPort;

    @!IpPermissions = @ipPermissions.map(-> $p is rw {
      if $p !~~ IpPermission {
        if .^lookup('IpPermission') -> $m {
          $p = $m($p);
        } else {
          die qq:to/DIE/.chomp;
            Invalid value passed to \@ipPermissions. Should only contain {
            '' }IpPermission objects, not { .^name }
            DIE
        }
      }
      $p;
    });

  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    my @args;
    for self.^attributes.sort( *.name ) {
      my $an = .name.substr(2);
      if $an eq 'IpPermissions' {
        my @ipp;
        my $cnt = 1;
        for @!IpPermissions {
          @args.push:
            Pair.new( "{ $an }.{ $cnt }.{ .key }", .value )
              for .pairs;
        }
        $cnt++;
      } else {
        my \av = .get_value(self);

        @args.push: Pair.new( $an, av ) if av;
      }
    }
    @args.push: Pair.new('Version', '2016-11-15');

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

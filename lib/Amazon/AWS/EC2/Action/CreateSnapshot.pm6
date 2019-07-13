use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;

use Amazon::AWS::EC2::Types::TagSpecification;

use Amazon::AWS::EC2::Response::CreateSnapshotResponse;

my %attributes;

class Amazon::AWS::EC2::Action::CreateSnapshot is export
  does XML::Class[xml-element => 'CreateSnapshot']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];
  
  has Str               $.Description                                                  is xml-element                      is xml-skip-null is rw;
  has Bool              $.DryRun                                                       is xml-element                      is xml-skip-null is rw;
  has TagSpecification  @.TagSpecifications  is xml-container('tagSpecificationSet')   is xml-element('item', :over-ride)                         is xml-skip-null is rw;
  has Str               $.VolumeId                                                     is xml-element                      is xml-skip-null is rw;
  
  submethod BUILD (
    :$description,
    :$dryRun,
    :@tagSpecifications,
    :$volumeId,
    # For deserialization purposes, only!
    :$!Description      = '',
    :$!DryRun           = False,
    :@!TagSpecifications,
    :$!VolumeId         = '',
  ) { 
    $!DryRun            = $dryRun if $dryRun;
    
    if @tagSpecifications {
      @!TagSpecifications = do given @tagSpecifications {
        when .all ~~ TagSpecification
          { $_ }
          
        default {
          die qq:to/DIE/
          Invalid values passed to \@tagSpecifications. Elements must only consist of TagSpecifications, but also contains:
          { .grep( * !~~ TagSpecification ).map( *.^name ).join(', ') }
          DIE
          
        }
      }
    }
        
    $!Description= $description 
      if $description.defined && $description.trim.chars;
    $!VolumeId = $volumeId
      if $volumeId.defined && $volumeId.trim.chars;
  }
  
  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die "VolumeId is required. Please set this attribute before executing .run!"
      unless $.VolumeId.chars;
      
    my @TagSpecArgs;
      
    # @Args must be sorted by key name.
    my @args;
    @args.push:   (Description => $.Description)  if $.Description.chars;
    @args.append: (
      DryRun           => $.DryRun,
      |@TagSpecArgs,
      Version          => '2016-11-15',
      VolumeId         => $.VolumeId
    );

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }
  
  method getValidInterfaceTypes {
    %attributes<InterfaceTypes|ValidValues>.Array;
  }
   
}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::CreateSnapshot
  );
}

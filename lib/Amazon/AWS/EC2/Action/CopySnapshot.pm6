use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::CopySnapshotResponse;

class Amazon::AWS::EC2::Action::CopySnapshot is export
  does XML::Class[xml-element => 'CopySnapshot']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];
  
  has Str               $.Description        is xml-element  is xml-skip-null is rw;
  has Str               $.DestinationRegion  is xml-element  is xml-skip-null is rw;
  has Bool              $.DryRun             is xml-element  is xml-skip-null is rw;
  has Bool              $.Encrypted          is xml-element  is xml-skip-null is rw;
  has Str               $.KmsKeyId           is xml-element  is xml-skip-null is rw;
  has Str               $.PresignedUrl       is xml-element  is xml-skip-null is rw;
  has Str               $.SourceRegion       is xml-element  is xml-skip-null is rw;
  has Str               $.SourceSnapshotId   is xml-element  is xml-skip-null is rw;
  
  submethod BUILD (
    :$description,
    :$destinationRegion,
    :$dryRun,
    :$encrypted,
    :$kmsKeyId,       
    :$presignedUrl,
    :$sourceRegion,
    :$sourceSnapshotId,
    # For deserialization purposes, only!
    :$!Description       = '',
    :$!DestinationRegion = '',
    :$!DryRun            = False,
    :$!Encrypted         = False,
    :$!KmsKeyId          = '',
    :$!PresignedUrl      = '',
    :$!SourceRegion      = '',
    :$!SourceSnapshotId  = ''
  ) { 
    $!Description       = $description 
      if $description.defined && $description.trim.chars;
    $!DestinationRegion = $destinationRegion
      if $destinationRegion.defined && $destinationRegion.trim.chars;
      
    $!DryRun            = False if $dryRun;
    $!Encrypted         = False if $encrypted;
    
    $!KmsKeyId          = '' if $kmsKeyId.defined && $kmsKeyId.trim.chars;
    $!PresignedUrl      = '' 
      if $presignedUrl.defined && $presignedUrl.trim.chars;
    $!SourceRegion      = '' 
      if $sourceRegion.defined && $sourceRegion.trim.chars;
    $!SourceSnapshotId  = '' 
      if $sourceSnapshotId.defined && $sourceSnapshotId.trim.chars;
    
  }
  
  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die "SourceRegion is required. Please set this attribute before executing .run!"
      unless $!SourceRegion.chars;
    die "SourceSnapshotId is required. Please set this attribute before executing .run!"
      unless $!SourceSnapshotId.chars;
      
    # @Args must be sorted by key name.
    my @args;
    @args.push:   (Description       => $!Description)       if $!Description.chars;
    @args.push:   (DestinationRegion => $!DestinationRegion) if $!DestinationRegion.chars;
    @args.push:   (DryRun            => $!DryRun);
    @args.push:   (Encrypted         => $!Encrypted);
    @args.push:   (KmsKeyId          => $!KmsKeyId)          if $!KmsKeyId.chars;
    @args.push:   (PresignedUrl      => $!PresignedUrl)      if $!PresignedUrl.chars;
    @args.append: (
      SourceRegion      => $!SourceRegion,
      SourceSnapshotId  => $!SourceSnapshotId,
      Version           => '2016-11-15',
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
   
}

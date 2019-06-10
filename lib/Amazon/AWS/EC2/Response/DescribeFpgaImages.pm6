use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::FpgaImage;

class Amazon::AWS::EC2::Types::Response::DescribeFpgaImagesResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has FpgaImage    @.fpgaImages    is xml-element    is xml-container('fpgaImageSet')      is rw; 
  has Str          $.nextToken     is xml-element                                          is rw; 
}
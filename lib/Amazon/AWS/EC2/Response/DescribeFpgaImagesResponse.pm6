use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::FpgaImage;

class Amazon::AWS::EC2::Response::DescribeFpgaImagesResponse is export
  does XML::Class[xml-element => 'DescribeFpgaImagesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has FpgaImage    @.fpgaImages                      is xml-container('fpgaImageSet')      is rw; 
  has Str          $.nextToken     is xml-element                                          is rw; 
}

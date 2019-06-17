use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::Image;

class Amazon::AWS::EC2::Response::DescribeImagesResponse is export
  does XML::Class[xml-element => 'DescribeImagesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Image    @.imagess    is xml-element    is xml-container('imagesSet')      is rw;
}

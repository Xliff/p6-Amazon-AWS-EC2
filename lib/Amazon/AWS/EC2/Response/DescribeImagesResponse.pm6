use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::Image;

class Amazon::AWS::EC2::Response::DescribeImagesResponse is export
  does XML::Class[xml-element => 'DescribeImagesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Image    @.images    is xml-container('imagesSet')    is rw;
}

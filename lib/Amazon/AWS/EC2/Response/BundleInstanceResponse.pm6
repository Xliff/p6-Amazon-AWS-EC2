use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::BundleTask;

class Amazon::AWS::EC2::Response::BundleInstanceResponse is export
  does XML::Class[xml-element => 'BundleInstanceResponse']
{
  also does Amazon::AWS::Roles::Response;

  has BundleTask    $.bundleInstanceTask    is xml-element          is rw; 
}
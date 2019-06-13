use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::BundleTask;

class Amazon::AWS::EC2::Response::CancelBundleTaskResponse is export
  does XML::Class[xml-element => 'CancelBundleTaskResponse']
{
  also does Amazon::AWS::Roles::Response;

  has BundleTask    $.bundleInstanceTask    is xml-element          is rw; 
}
use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::BundleTask;

class Amazon::AWS::EC2::Types::Response::DescribeBundleTasksResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has BundleTask    @.bundleInstanceTaskss    is xml-element    is xml-container('bundleInstanceTasksSet')      is rw; 
}
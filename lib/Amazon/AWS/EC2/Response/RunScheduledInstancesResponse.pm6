use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::RunScheduledInstancesResponse is export
  does XML::Class[xml-element => 'RunScheduledInstancesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    @.instanceIds    is xml-element    is xml-container('instanceIdSet')      is rw; 
}
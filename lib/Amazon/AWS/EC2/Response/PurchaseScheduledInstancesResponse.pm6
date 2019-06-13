use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ScheduledInstance;

class Amazon::AWS::EC2::Response::PurchaseScheduledInstancesResponse is export
  does XML::Class[xml-element => 'PurchaseScheduledInstancesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has ScheduledInstance    @.scheduledInstances    is xml-element    is xml-container('scheduledInstanceSet')      is rw; 
}
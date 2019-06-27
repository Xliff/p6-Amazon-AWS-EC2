use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ConversionTask;

class Amazon::AWS::EC2::Response::DescribeConversionTasksResponse is export
  does XML::Class[xml-element => 'DescribeConversionTasksResponse']
{
  also does Amazon::AWS::Roles::Response;

  has ConversionTask    @.conversionTasks    is xml-container('conversionTaskSet')      is rw; 
}

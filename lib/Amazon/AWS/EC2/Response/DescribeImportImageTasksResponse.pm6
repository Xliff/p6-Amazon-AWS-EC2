use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ImportImageTask;

class Amazon::AWS::EC2::Response::DescribeImportImageTasksResponse is export
  does XML::Class[xml-element => 'DescribeImportImageTasksResponse']
{
  also does Amazon::AWS::Roles::Response;


  has ImportImageTask    @.importImageTasks    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('importImageTaskSet')      is rw;
  has Str                $.nextToken           is xml-element                        is xml-skip-null                                                is rw;
}

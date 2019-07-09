use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::PrefixList;

class Amazon::AWS::EC2::Response::DescribePrefixListsResponse is export
  does XML::Class[xml-element => 'DescribePrefixListsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has PrefixList    @.hostIds                    is xml-container('prefixListSet')  is xml-skip-null is rw; 
  has Str           $.nextToken  is xml-element                                     is xml-skip-null is rw;
  
  
}

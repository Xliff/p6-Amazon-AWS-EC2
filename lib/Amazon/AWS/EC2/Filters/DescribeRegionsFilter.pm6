use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;

class Amazon::AWS::EC2::Filters::DescribeRegionsFilter is export
    does XML::Class[xml-element => 'item']
{
    also does Amazon::AWS::Roles::Base;

    has Str $.endpoint                                       is xml-element                is rw;
    has Str $.region-name                                    is xml-element                is rw;
}

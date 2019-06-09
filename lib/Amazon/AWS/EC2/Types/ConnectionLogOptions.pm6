use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ConnectionLogOptions is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.CloudwatchLogGroup     is xml-element          is rw; 
  has Str     $.CloudwatchLogStream    is xml-element          is rw; 
  has Bool    $.Enabled                is xml-element          is rw; 
}
use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::NewDhcpConfiguration is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.Key       is xml-element                                    is rw; 
  has Str    @.Values    is xml-element    is xml-container('Values')      is rw; 
}
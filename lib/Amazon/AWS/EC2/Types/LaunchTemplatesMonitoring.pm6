use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::LaunchTemplatesMonitoring is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.enabled    is xml-element    is xml-skip-null          is rw;
}

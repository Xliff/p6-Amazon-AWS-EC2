use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::VgwTelemetry is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.acceptedRouteCount    is xml-element    is xml-skip-null          is rw; 
  has Str    $.lastStatusChange      is xml-element    is xml-skip-null          is rw; 
  has Str    $.outsideIpAddress      is xml-element    is xml-skip-null          is rw; 
  has Str    $.status                is xml-element    is xml-skip-null          is rw;   #=  UP | DOWN
  has Str    $.statusMessage         is xml-element    is xml-skip-null          is rw; 
}
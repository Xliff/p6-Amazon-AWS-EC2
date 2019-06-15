use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::VolumeStatusDetails;

class Amazon::AWS::EC2::Types::VolumeStatusInfo is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has VolumeStatusDetails    @.details    is xml-element    is xml-skip-null    is xml-container('details')      is rw;
  has Str                    $.status     is xml-element    is xml-skip-null                                     is rw;   #=  ok | impaired | insufficient-data
}

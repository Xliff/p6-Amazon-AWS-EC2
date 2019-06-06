use v6.d;

use XML::Class;

class Amazon::AWS::EC2::InstanceNetworkInterfaceAttachment is export
  does XML::Class[xml-element => 'attachment']
{
  has Str  $.attachmentId         is xml-element is rw;
  has Str  $.attachTime           is xml-element is rw;
  has Bool $.deleteOnTermination  is xml-element is rw;
  has Int  $.deviceIndex          is xml-element is rw;
  has Str  $.status               is xml-element is rw;

  method setStatus($val) {
    my @valid-values = <attaching attached detaching detached>;
    die "Invalid status value '{$val}'. Valid options are: {
         @valid-values.join(', ') }"
    unless $val ~~ @valid-values.any;
  }

}

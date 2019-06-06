use v6.d;

use XML::Class;

class Amazon::AWS::EC2::ProductCode is export
  does XML::Class[xml-element => 'item']
{

  has Str $.productCode is xml-element is rw;
  has Str $.type        is xml-element;

  method setType($newType) {
    my @valid-types = <devpay marketplace>;
    die "Invalid instance type '{$newType}'. Valid instance types are:\n{
        @valid-types.join(', ') }"
    unless $newType eq @valid-types.any;
    $!type = $newType;
  }

}

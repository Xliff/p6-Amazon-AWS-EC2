use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::ProductCode is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str $.productCode is xml-element is xml-skip-null is rw;
  has Str $.type        is xml-element is xml-skip-null is rw;

  method setType($newType) {
    my @valid-types = <devpay marketplace>;
    die "Invalid instance type '{$newType}'. Valid instance types are:\n{
        @valid-types.join(', ') }"
    unless $newType eq @valid-types.any;
    $!type = $newType;
  }

}

use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::VpcCidrBlockState is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.state            is xml-element    is xml-skip-null          is rw;   #=  associating | associated | disassociating | disassociated | failing | failed
  has Str    $.statusMessage    is xml-element    is xml-skip-null          is rw;
}

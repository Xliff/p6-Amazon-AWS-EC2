use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::InternetGateway;

class Amazon::AWS::EC2::Response::DescribeInternetGatewaysResponse is export
  does XML::Class[xml-element => 'DescribeInternetGatewaysResponse']
{
  also does Amazon::AWS::Roles::Response;

  has InternetGateway    @.internetGateways                    is xml-container('internetGatewaySet')  is rw; 
  has Str                $.nextToken         is xml-element                                            is rw; 
}

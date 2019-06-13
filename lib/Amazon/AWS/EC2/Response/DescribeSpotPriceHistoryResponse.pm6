use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::SpotPrice;

class Amazon::AWS::EC2::Response::DescribeSpotPriceHistoryResponse is export
  does XML::Class[xml-element => 'DescribeSpotPriceHistoryResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str          $.nextToken            is xml-element                                                 is rw; 
  has SpotPrice    @.spotPriceHistorys    is xml-element    is xml-container('spotPriceHistorySet')      is rw; 
}
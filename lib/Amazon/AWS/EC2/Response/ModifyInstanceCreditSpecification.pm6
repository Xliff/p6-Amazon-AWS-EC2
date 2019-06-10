use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::SuccessfulInstanceCreditSpecificationItem;
use Amazon::AWS::EC2::Types::UnsuccessfulInstanceCreditSpecificationItem;

class Amazon::AWS::EC2::Types::Response::ModifyInstanceCreditSpecificationResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has SuccessfulInstanceCreditSpecificationItem      @.successfulInstanceCreditSpecifications      is xml-element    is xml-container('successfulInstanceCreditSpecificationSet')        is rw; 
  has UnsuccessfulInstanceCreditSpecificationItem    @.unsuccessfulInstanceCreditSpecifications    is xml-element    is xml-container('unsuccessfulInstanceCreditSpecificationSet')      is rw; 
}
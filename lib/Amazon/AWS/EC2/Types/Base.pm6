use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Types::Base does Amazon::AWS::Roles::Base {
  also does Amazon::AWS::Roles::Eqv;
}

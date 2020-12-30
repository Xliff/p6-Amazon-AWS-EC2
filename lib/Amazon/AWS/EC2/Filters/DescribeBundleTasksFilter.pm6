use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Filters::DescribeBundleTasksFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str   $.bundle-id       is xml-skip-null is xml-element is rw;
  has Str   $.error-code      is xml-skip-null is xml-element is rw;
  has Str   $.error-message   is xml-skip-null is xml-element is rw;
  has Str   $.instance-id     is xml-skip-null is xml-element is rw;
  has Str   $.progress        is xml-skip-null is xml-element is rw; #= !PERCENTAGE
  has Str   $.s3-bucket       is xml-skip-null is xml-element is rw;
  has Str   $.s3-prefix       is xml-skip-null is xml-element is rw;
  has Str   $.start-time      is xml-skip-null is xml-element is rw;
  has Str   $.state           is xml-skip-null is xml-element is rw; #= pending | waiting-for-shutdown | bundling | storing | cancelling | complete | failed
  has Str   $.update-time     is xml-skip-null is xml-element is rw;

  submethod BUILD (
    :$!bundle-id,
    :$!error-code,
    :$!error-message,
    :$!instance-id,
    :$progress,
    :$!s3-bucket,
    :$!s3-prefix,
    :$start-time,
    :$!state,
    :$update-time
  ) {
    # Validation.
    $!progress    = self.handlePercentageAsString($progress);
    $!start-time  = self.handleDateTimeAsString($start-time);
    $!update-time = self.handleDateTimeAsString($update-time);
  }

}

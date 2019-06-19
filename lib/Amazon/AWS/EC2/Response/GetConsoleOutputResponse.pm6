use v6.d;

use Base64::Native;

use Amazon::AWS::Roles::Response;

use XML::Class;


class Amazon::AWS::EC2::Response::GetConsoleOutputResponse is export
  does XML::Class[xml-element => 'GetConsoleOutputResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.instanceId    is xml-element          is rw;
  has Str    $.output        is xml-element          is rw;
  has Str    $.timestamp     is xml-element          is rw;

  method getDecodedOutput { base64-decode($.output).decode }
  method lines            { self.getDecodedOutput.lines    }
}

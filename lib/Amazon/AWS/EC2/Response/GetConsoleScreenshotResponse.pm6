use v6.d;

use Method::Also;

use Base64::Native;

use Amazon::AWS::Roles::Response;

use XML::Class;


class Amazon::AWS::EC2::Response::GetConsoleScreenshotResponse is export
  does XML::Class[xml-element => 'GetConsoleScreenshotResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.imageData     is xml-element          is rw;
  has Str    $.instanceId    is xml-element          is rw;

  method getDecodedOutput { base64-decode($.imageData) }

  method write-jpg ($filename = 'AWSConsoleScreenshot.jpg')
    is also<
      write_jpg
      write-jpeg
      write_jpeg
    >
  {
    warn "Outputting JPEG file '{$filename}'..."
      unless [||](
        $filename.ends-with('jpeg'),
        $filename.ends-with('jpg')
      );
    $filename.IO.spurt(self.getDecodedOutput, :close)
  }
}

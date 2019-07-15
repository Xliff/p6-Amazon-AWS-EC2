use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::GetPasswordDataResponse is export
  does XML::Class[xml-element => 'GetPasswordDataResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.instanceId      is xml-element          is rw; 
  has Str    $.passwordData    is xml-element          is rw; 
  has Str    $.timestamp       is xml-element          is rw; 
  
  method getDecryptedPassword($keyFile) {
    unless $.passwordData.defined && $.passwordData.chars {
      warn 'No password data found!';
      return;
    }
      
    die 'keyFile does not exist' unless $keyFile.IO.e;
    
    my $pwExtract = $!passwordData ~~ /^ "\&#xd;\n" (.+?) "==&#xd;\n" /;
    die 'No password data found in response!' unless $/[0];
    
    use Base64::Native; 
    my ($p, $pw) = ( Proc::Async.new(
      |<openssl rsautl -decrypt -inkey>,
      $keyFile, 
      :w
    ) ); 
    
    $p.stdout.tap(-> $v { $pw ~= $v }); 
    my $promise = $p.start; 
    await $p.write( base64-decode($/[0].Str) ); 
    $p.close-stdin; 
    await $promise; 
    $pw;
  }
  
}

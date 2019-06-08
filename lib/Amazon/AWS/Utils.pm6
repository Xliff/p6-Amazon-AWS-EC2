use v6.d;

use Base64::Native;
use Cro::HTTP::Client;
use DateTime::Format;
use Digest;
use Digest::HMAC;
use Digest::SHA256::Native;

constant algorithm = 'AWS4-HMAC-SHA256';
constant default_key_location = '/home/cbwood/.ec2/EC2AccessKeys.csv';
constant empty_payload_hash = 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855';
constant host = 'ec2.amazonaws.com';
constant region = 'us-east-1';
constant service = 'ec2';
constant terminator = 'aws4_request';

unit package Amazon::AWS::Utils;

my (@range, @charValue);
BEGIN {
  @range     = (5...30);
  @charValue = 'a'...'z', 'A'...'Z';
}

sub sign($k, $m) {
  hmac($k, $m, &sha256);
}

sub getSignatureKey($k, $d, $r, $s) {
  my $kDate    = sign("AWS4{$k}", $d);
  my $kRegion  = sign($kDate, $r);
  my $kService = sign($kRegion, $s);
  my $kSigning = sign($kService, 'aws4_request');
}

sub getLocalAccess {
  die 'Cannot find personalized information'
    unless default_key_location.IO.e;
  my ($ak, $sk);
  try {
    CATCH { default { die 'Invalid format'; } }
    ($ak, $sk) = default_key_location.IO.slurp.lines[1].split(',');
  }
  ($ak, $sk);
}

sub makeRequest ($uri, :$method = 'GET', :$body, *%headers) is export {
  say "URI: { $uri }";
  my $t = DateTime.now(timezone => 0);            # MUST be in GMT
  my $amzdate = strftime('%Y%m%dT%H%M%SZ', $t);
  #my $amzdate = '20190604T233232Z';
  my $datestamp = strftime('%Y%m%d', $t);
  my ($canonUri, $canonQS) = $uri.split('?');
  $canonUri = '/' unless $canonUri.chars;
  %headers.append: (x-amz-date => $amzdate, host => host);
  my $canonHeaders = %headers
    .pairs
    .sort( *.key )
    .map({ "{.key.lc}:{.value}" })
    .join("\n") ~ "\n";
  my $signedHeaders = 'host;x-amz-date'; # %headers.pairs.sort( *.key ).map( *.key.lc ).join(';');
  my $canonReq = (
    $method,
    $canonUri,
    $canonQS,
    $canonHeaders,
    $signedHeaders,
    empty_payload_hash
  ).join("\n");
  my $credScope = ($datestamp, region, service, terminator).join('/');
  my $signString = (
    algorithm,
    $amzdate,
    $credScope,
    sha256-hex($canonReq)
  ).join("\n");
  my ($ak, $sk) = getLocalAccess;
  my $signingKey = getSignatureKey($sk, $datestamp, region, service);

  my $signature = hmac-hex($signingKey, $signString, &sha256);

  %headers<Authorization> =
    "{algorithm} Credential={$ak}/{$credScope}, SignedHeaders={$signedHeaders
  }, Signature={$signature}";


  # # FINALLY make the request
  my $r = do given $method {
    my $url = "https://{host}$uri";
    %headers<host>:delete;
    when 'GET' {
      await Cro::HTTP::Client.get: $url, headers => %headers.pairs;
    }
    when 'POST' {
      await Cro::HTTP::Client.post:
        $url, headers => %headers.pairs, body => $body;
    }
  }
  my $b = await $r.body;
  $b;
}

sub populateTestObject($object, :$blanks = True) is export {
  for $object.^attributes -> $a {
    # 10% chance for an undefined attr.
    if $blanks { next unless (^10).pick }

    sub generateValue($_) {
      do {
        when Str  { (gather for ^@range.pick { take @charValue.pick }).join() }
        when Bool { Bool.pick         }
        when Int  { @range.pick       }
        when Num  { @range.max * rand }

        default   { populateTestObject( .new ) }
      }
    }

    $object."{ $a.name.substr(2) }"() = do given $a.type {
      when Positional {
        do gather for ^((^5).pick) -> $i { take generateValue(.of) }
      }

      default         { generateValue($_) }
    }
  }
  $object;
}

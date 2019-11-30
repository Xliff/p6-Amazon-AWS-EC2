use v6.d;

use Base64::Native;
use Cro::HTTP::Client;
use DateTime::Format;
use Digest;
use Digest::HMAC;
use Digest::SHA256::Native;

use Amazon::AWS::Response::ErrorResponse;

constant algorithm            = 'AWS4-HMAC-SHA256';
constant default_key_location = '/home/cbwood/.ec2/default.csv';
constant empty_payload_hash   = 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855';
constant host                 = 'ec2.amazonaws.com';
constant region               = 'us-east-1';
constant service              = 'ec2';            #= This can be optimized OUT if made generic across AWS.
constant terminator           = 'aws4_request';

unit package Amazon::AWS::Utils;

our $number-of-requests = 0;

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
  do try {
    CATCH { default { .message.say; die 'Invalid format'; } }
    my $access_file = default_key_location.IO.slurp;
    my %idx = (
      do gather for $access_file.lines[0].split(',').kv -> $k, $v {
        take Pair.new($v.trim, $k.trim)
          if $v eq ('Access key ID', 'Secret access key').any;
      }
    );

    # Embedded spaces in key so curly brace hash access is mandatory.
    $access_file.lines[1].split(',')[
      %idx{'Access key ID'}.trim,
      %idx{'Secret access key'}.trim,
    ];
  }
}

sub urlEncode($val) is export {
  # From: https://www.rosettacode.org/wiki/URL_encoding#Perl_6
  $val.subst(/<-alnum>/, *.ord.fmt("%%%02X"), :g);
}

sub makeHeaders ($uri, $method) {
  my %headers;
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

  # Note, Content-Type is not included. Future versions of this API will need
  # to adjust for this omission.

  # Original:
  my $signedHeaders = %headers.pairs.sort( *.key ).map( *.key.lc ).join(';');
  # Stubbed:
  # my $signedHeaders = 'host;x-amz-date';

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

  %headers;
}

sub makeRequest (
  $uri       is copy,
  :$method   = 'GET',
  :$service,              #= For future use
  :$body,
  *%headers
) is export {
  say "URI: { $uri }";

  die 'URI exceeds maximum recommended size of 1024 characters. Please shorten.'
    unless $uri.chars < 1025;

  # # FINALLY make the request
  my $r = do given $method {
    CATCH {
      # Dynamic lookup performed
      when X::Cro::HTTP::Error {
        my $body = await .response.body;
        $body .= decode if $body ~~ Buf;
        if $body.starts-with('<?xml') {
          $body = ErrorResponse.from-xml($body);
          say "\nAdditional Error Message(s):";
          say "    - { .Message } ({ .Code })" for $body.errors;
        } else {
          say "\nAdditional Error Message: { $body.decode }";
        }
        say '';
        .rethrow
      }
    }

    %headers.append( makeHeaders($uri, $method) );
    my $url = "https://{host}$uri";
    %headers<host>:delete;
    when 'GET' {
      await Cro::HTTP::Client.get: $url, headers => %headers.pairs;
    }
    when 'POST' {
      await Cro::HTTP::Client.post:
        $url, headers => %headers.pairs, body => $body;
    }
    $number-of-requests++;
  }
  my $b = await $r.body;
  $b;
}

sub populateTestObject(
  $object,           #= Object instance to populate
  :$blanks = True,   #= Whether or not to randomly generate empty attributes
  :$chance = 10,     #= Chance of generating a blank = (1/chance)
  :$elems  = 5,      #= If a list, random number up to given value.
  :$invert = False   #= Invert chance computation.
) is export {
  for $object.^attributes -> $a {
    # 10% chance for an undefined attr.
    if $blanks {
      $invert ??
        (next if (^$chance).pick)
        !!
        (next unless (^$chance).pick);
    }

    sub generateValue($_) {
      do {
        when Bool { Bool.pick         }
        when Str  {
          my @values;
          if (my $options = $a.WHY).defined {
            $options ~~ /('?')? \s* (<[\\\w\-\:]>+)+ %% [ \s* '|' \s* ]/;
            # YYY - TODO: Do away with implicit conversion fom Array to Str
            my $vals = $/[1];
            # Remove 'regex:' from beginning of alternation string, if present.
            $vals .= substr( 'regex:'.chars ) if $vals.starts-with('regex:');
            # Split on space. Select random value from resulting array.
            my $v = (do gather for $vals.split(' ').Array { take .Str }).flat.pick;
            # Int as Str (conditional)
            $v = @range.pick.Str if $v.starts-with('\\d');
            $v;
          } else {
            (gather for ^@range.pick { take @charValue.pick }).join()
          }
        }
        when Int  { @range.pick       }
        when Num  { @range.max * rand }

        default   { populateTestObject( .new, :$blanks, :$chance, :$invert, :$elems ) }
      }
    }

    $object."{ $a.name.substr(2) }"() = do given $a.type {
      when Positional | Array {
        my $start = 0;
        ++$start unless $blanks;
        do gather for ^(($start...$elems).pick) -> $i { take generateValue(.of) }
      }

      default         { generateValue($_) }
    }
  }
  $object;
}

sub makeAttributeTable(%attributes, $attrName) is export {
  %attributes{"{ $attrName }|MaxLength"} =
    %attributes{"{ $attrName }|ValidValues"}.map( *.chars ).max;
  if %attributes{"{ $attrName }|ValidValues"}:exists {
    %attributes{"{ $attrName }|Table"} = (
      do gather for %attributes{"{ $attrName }|ValidValues"}.batch(3) {
        take "\t" ~
          .Array.fmt("%-{ %attributes{"{ $attrName }|MaxLength"} + 4 }s").join('')
      }
    ).join("\n");
  }
}

sub getAttributeData($type) is export  {
  my %attributes;

  die 'getAttributeData only runs on classes!'
    unless $type.HOW ~~ Metamodel::ClassHOW;

  for $type.^attributes {
    my $attrName = .name.substr(2);
    %attributes{$attrName} = $_;
    quietly {
      given %attributes{$attrName}.WHY {
        when /\s* 'regex:' (.+) $/ {
          my $regex = $/[0].Str;
          %attributes{"{ $attrName }|ValidRegex"} = / $regex /;
        }
        when /('?')? \s* (<[\w\-]>+)+ %% [ \s* '|' \s* ]/ {
          %attributes{"{ $attrName }|ValidValues"} = (do
            gather for $/[1].Array {
              take .Str
            }
          ).flat.Array;
          makeAttributeTable(%attributes, $attrName) if $/;
        }
      }
    }
  }

  %attributes;
}

sub errorBadContents(\a, \t) is export {

  die qq:to/DIE/.chomp;
  Invalid value passed to { a.VAR.name }. Should only contain { t.^shortname } objects, but also contains:
  { a.grep( * !~~ t ).map( *.^name ).unique.join('. ') }
  DIE

}

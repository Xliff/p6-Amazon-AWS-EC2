use v6.d;

use LWP::Simple;
use Mojo::DOM:from<Perl5>;

sub MAIN (Str $url) {
  my $dom = Mojo::DOM.new( LWP::Simple.get($url) );

  my ($className, @attributes);
  quietly {
    $className = $dom.find('h1').to_array[0].text;

    for $dom.find('div.variablelist span.term b').to_array -> $ne {
      my ($attrName, $attrType, $sigil, $validValues, $container) =
        ($ne.text, '');

      my $nn = $ne.parent.parent.next_node;
      while not $nn.tag.defined {
        $nn .= next_node;
      }

      for $nn.find('p').to_array -> $te {
        next unless $te.text.defined && $te.text.chars;
        next unless [||](
          $te.text.starts-with('Type:'),
          $te.text.starts-with('Valid Values:')
        );

        given $te.text {
          when /^ 'Type:'/ {
            $attrType = do {
              if $te.text.starts-with('Type: Array of') {
                $sigil = '@.';
                $te.find('a').to_array[0].text;
              } else {
                $sigil = '$.';
                $te.text ~~ /'Type: ' (.+)$/;
                do given $/[0] {
                  when 'String'  { 'Str'  }
                  when 'Integer' { 'Int'  }
                  when 'Boolean' { 'Bool' }

                  default        { die "Don't know how to handle type '{ $_ }'" }
                }
              }
            }
          }

          when /^ 'Valid Values:'/ {
            $validValues = $te.find('code').to_array[0].text;
          }
        }
        # Emit xml-container('attrName') if sigil starts with @.
        if $sigil.starts-with('@') {
          my $oldAttrName = $attrName;
          $attrName ~~ s/'ValueSet'/s/;
          $container = "is xml-container('{$oldAttrName}')";
        }
      }

      @attributes.push: [
        $attrType,
        $attrName,
        $sigil,
        'is xml-element',
        $container,
        $validValues
      ];
    }
  }

  my @extraTypes = do gather for @attributes.map( *[0] ) {
    when 'Str' | 'Int' | 'Bool' {         } # Do nothing
    default                     { take $_ }
  }

  my $attrCol = @attributes.map( *[0].chars ).max + 4;
  my $nameCol = @attributes.map( *[1].chars ).max + 4;
  my $elemCol = @attributes.map( *[3].chars ).max + 4; #@attributes.map({ ($_[3] // '').chars }).max + 4;
  my $contCol = @attributes.map({ ($_[4] // '').chars }).max + 4;

  my @attrDefs;
  for @attributes -> $a {
    @attrDefs.push: "  has {
                       $a[0]        .fmt("%-{$attrCol}s") }{ $a[2] }{
                       $a[1]        .fmt("%-{$nameCol}s") }{
                       $a[3]        .fmt("%-{$elemCol}s") }{
                       ($a[4] // '').fmt("%-{$contCol}s") }  is rw; {
                       $a[5].defined ?? "  #= { $a[5] }" !! '' }";
  }

  my $preamble1 = qq:to/PRE1/.chomp;
  use v6.d;

  use Amazon::AWS::EC2::Types::Base;

  use XML::Class;

  { @extraTypes.sort.map( 'Amazon::AWS::EC2::Types::' ~ *  ~ ';' ).join("\n") }

  class Amazon::AWS::EC2::Types::{ $className } is export
    does XML::Class[xml-element => 'item']
  \{
    also is Amazon::AWS::EC2::Types::Base;

  { @attrDefs.join("\n") }
  \}
  PRE1

  $preamble1.say;

}

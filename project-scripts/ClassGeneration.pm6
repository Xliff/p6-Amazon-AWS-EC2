use v6.d;

unit package ClassGeneration;

use LWP::Simple;
use Mojo::DOM:from<Perl5>;
use Mojo::URL:from<Perl5>;

sub makeClass (Str $url, :$response = False, :$action = False) is export {
  my $dom = Mojo::DOM.new( LWP::Simple.get($url) );

  my ($className, @attributes);

  CATCH {
    default {
      @attributes.gist.say;
      .rethrow
    }
  }

  quietly {
    $className = $dom.find('h1').to_array[0].text;

    my @vl = $dom.find('div.variablelist').to_array;
    # .text.say for @vl[0].find('span.term b').to_array;
    # say '»»»»»»';
    # .text.say for @vl[1].find('span.term b').to_array;
    # @vl.say;
    # exit;
    my $vl = $response ?? @vl[1] !! @vl[0];

    for $vl.find('span.term b').to_array -> $ne {
      my ($attrName, $attrType, $sigil, $validValues, $container, $skipnull) =
        ($ne.text, '');
      my $override = False;
      next if $ne.text eq 'requestId';
      $skipnull = True;

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
                if (my $link = $te.find('a').to_array[0]) {
                  $override = True;
                  $link.text;
                } else {
                  $te.text ~~ /'Array of ' (\w+)/;
                  do given $/[0] {
                    when not .defined { die 'Missing array type!' }
                    when 'strings'    { 'Str' }
                    when 'integers'   { 'Int' }

                    default {
                      die "Unknown array type '{$/[0]}";
                    }
                  }
                }
              } else {
                $sigil = '$.';
                $te.text ~~ /'Type: ' (.+)$/;
                if (my $link = $te.find('a').to_array[0]) {
                  $link.text;

                } else {
                  do given $/[0] {
                    when 'String'    { 'Str'  }
                    when 'Integer'   { 'Int'  }
                    when 'Boolean'   { 'Bool' }
                    when 'Timestamp' { 'Str'  }
                    when 'Double'    { 'Num'  }
                    when 'Long'      { 'Int'  }
                    when 'Float'     { 'Num'  }

                    when 'Base64-encoded binary data'        { 'Str' }
                    when 'Base64-encoded binary data object' { 'Str' }

                    default {
                      die "Don't know how to handle type '{ $_ }' for { $attrName }"
                    }
                  }
                }
              }
            }
          }

          when /^ 'Valid Values:'/ {
            if $attrType ne 'Str' || $attrName.lc ne 'instanttype' {
              $validValues = $te.find('code').to_array[0].text;
              $validValues ~~ s:g/ \s+ / /;
            } else {
              # Note potential sub-call declaration.
              $validValues = '#=  validation:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType';
            }
          }
        }

        $attrType = $className ~ 'Filter' if $attrType eq 'Filter';

        # Emit xml-container('attrName') if sigil starts with @.
        if $sigil.starts-with('@') {
          $attrName ~~ s/.N$/s/;
          my $oldAttrName = $attrName;
          $oldAttrName.substr-rw(0, 1) = $oldAttrName.substr(0, 1).lc;
          $oldAttrName ~= 'Set' unless $response;
          $oldAttrName ~~ s/SetSet/Set/;
          $container = "is xml-container('{$oldAttrName}')";
          $attrName ~~ s/'ValueSet'/s/;
          $attrName ~~ s/'Set'$/s/;
        }
      }

      @attributes.push: [
        $attrType,
        $attrName,
        $sigil,
        $sigil.starts-with('@') ?? "is xml-element('item', :over-ride)"
                                !! 'is xml-element' ~ (
                                  $override ?? '(:over-ride)'
                                            !! ''
                                ),

        $container,
        $validValues,
        'is xml-skip-null',
      ];
    }
  }

  my @extraTypes = do gather for @attributes.map( *[0] ) {
    when 'Str' | 'Int' | 'Bool' | 'Num'  {         } # Do nothing
    default                              { take $_ }
  };
  @extraTypes .= unique;

  my $attrCol = @attributes.map( *[0].chars ).max + 4;
  my $nameCol = @attributes.map( *[1].chars ).max + 4;
  my $elemCol = @attributes.map( *[3].chars ).max + 4; #@attributes.map({ ($_[3] // '').chars }).max + 4;
  my $snCol   = @attributes.map( *[6].chars ).max + 4;
  my $contCol = @attributes.map({ ($_[4] // '').chars }).max + 4;

  my @attrDefs;
  for @attributes -> $a {
    @attrDefs.push: "  has {
                       $a[0]        .fmt("%-{$attrCol}s") }{ $a[2] }{
                       $a[1]        .fmt("%-{$nameCol}s") }{
                       $a[3]        .fmt("%-{$elemCol}s") }{
                       $a[6]        .fmt("%-{$snCol  }s") }{
                       ($a[4] // '').fmt("%-{$contCol}s") }  is rw; {
                       $a[5].defined ?? "  #= { $a[5] }" !! '' }";
  }

  # Really should be separated out into a view.
  my ($dependent, $also, $xml-item, $mode, $shortname) = do {
    if $response {
      (
        'use Amazon::AWS::Roles::Response;',
        'also does Amazon::AWS::Roles::Response;',
        "{ $className }Response",
        'Response',
        ''
      );
    } elsif $action {
      my $d = q:to/DEP/,
        use Method::Also;

        use Amazon::AWS::Utils;
        use Amazon::AWS::Roles::Eqv;
        DEP
      (
        $d,
        "also does Amazon::AWS::Roles::Eqv;",
         'item',
         'Action',
         "\n" ~ '  my $c = ::?CLASS.^shortname;'
      );
    } else {
      (
        'use Amazon::AWS::EC2::Types::Base',
        'also is Amazon::AWS::EC2::Types::Base',
        'item',
        'Types',
        ''
      );
    }
  }

  my $run = '';
  $run = q:to/RUN/ if $action;
      method run (:$raw)
        is also<
          do
          execute
        >
      {
        # Should already be sorted.
        my @args = (
          DryRun     => $!DryRun,
          Version    => '2016-11-15'
        );

        # XXX - Add error handling to makeRequest!
        my $xml = makeRequest(
          "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
        );

        $raw ??
          $xml
          !!
          ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
      }

    RUN

  my $pre = qq:to/PRE1/.chomp;
    use v6.d;

    { $dependent }

    use XML::Class;

    { @extraTypes.sort.map({
        my $mode = .ends-with('Filter') ?? 'Filters' !! 'Types';
        "use Amazon::AWS::EC2::{ $mode }::{ $_ };"
      }).join("\n") }
    { $response ?? '' !! "use Amazon::AWS::EC2::Response::{ $className }Response;" }

    class Amazon::AWS::EC2::{ $mode }::{ $className }{
      $response ?? 'Response' !! ''
    } is export
      does XML::Class[xml-element => '{ $xml-item }']
    \{
      { $also }
    { $shortname }

    { @attrDefs.join("\n") }

    { $run }\}
    PRE1

  $pre;
}

sub processClass ($url, :$response) {
  $url ~~ / '_' (\w+) '.html' $/;
  die "Cannot find class name from '{ $url }'" unless $/[0].defined;

  my $optSuffix = $response ?? 'Response' !! '';
  my $className =$/[0] ~ $optSuffix;

  say "Processing { $className }...";

  my $classDef = makeClass($url, :$response);

  # Make the directory. Naked literal needs to be replaced!
  "genClasses/".IO.mkdir(0o744);

  # Output the class.
  "genClasses/{ $className }.pm6".IO.spurt($classDef);
}

sub doSpider ($url, :$response = False, :$threads) is export {
  my $dom = Mojo::DOM.new( LWP::Simple.get($url) );

  my @hrefs = $dom.find('ul.itemizedlist a')
                  .to_array
                  .map({
                    Mojo::URL.new( .attr('href') )
                             .to_abs( Mojo::URL.new($url) )
                             .to_string
                  });


  @hrefs.map({ processClass($_, :$response) });
}

use Cro::HTTP::Client;
use Amazon::AWS::Utils;

my $attempts = 500;
my $url = 'https://github.com/Xliff/p6-Amazon-AWS-EC2/?me=you&him=they';

{
  for ^$attempts {
    CATCH { default { say "Exception thrown after { $_ + 1 } requests";
                      .rethrow } }

    Cro::HTTP::Client.get: $url;
    sleep 1;
  }
}

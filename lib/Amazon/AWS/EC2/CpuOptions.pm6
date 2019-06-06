use XML::Class;

class Amazon::AWS::EC2::CpuOptions is export
  does XML::Class[xml-element => 'cpuOptions']
{
  has Int $.coreCount      is xml-element;
  has Int $.threadsPerCore is xml-element;
}

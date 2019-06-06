use XML::Class;

class Amazon::AWS::EC2::CpuOptions is export
  does XML::Class[xml-element => 'cpuOptions']
{
  has Int $.coreCount      is xml-element is rw;
  has Int $.threadsPerCore is xml-element is rw;
}

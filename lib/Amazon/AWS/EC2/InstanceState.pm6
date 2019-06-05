use v6.c;

use XML::Class;

class InstanceState does XML::Class {
  has Int $.code is xml-element;
  has Str $.name is xml-element;
}

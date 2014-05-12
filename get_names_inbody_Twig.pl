#!/usr/bin/perl

# Iris,may 2014
# Script to parse the CARDS and PS letters with the Twig module, instead of hacking with regular expressions.
# in this case I want to print a sub element <name> only when it occurs in the body part of the TEI document.

use strict;
use XML::Twig;  
use utf8;
binmode(STDOUT, ":utf8");


my $file = $ARGV[0];

get_XML_content($file);
     

sub get_XML_content{

my $file = $_[0];

# create a sub tree of the full document that only contains the body part
# and create an handler that extract the name parts

my $twig= new XML::Twig( twig_roots    => { 'body' => 1 },
                                            
                         twig_handlers => { 'name'=> \&h_name } ); 

$twig->parsefile( "$file");     
}


# simple handler that extracts text from an element                 
sub h_name{ 
  my( $tree, $elem)= @_;                      # handlers params are always
                                                             # the twig and the element
  my $string  = $elem->text;                # get the text of element           
  print "$string\n";
 }
 
 
                                      
                                                             
      
 
 

use strict;
use XML::Twig;  
use utf8;
 
binmode(STDOUT, ":utf8");
  
#read in XML file list

my $path= "/Users/irishendrickx/CLUL/CARDS/Data/Spaans/mei2014";

my $list = $ARGV[0];  #trainset_list.txt
my $outpath = $ARGV[1];  #/Users/irishendrickx/CLUL/CARDS/Data/Spaans/mei2014/NormColTrain

open(LIST, $list);  
while(<LIST>)
{
	my ($filename, $year) = split /\s+/, $_;
    my $file = "$path/edictor/$filename"."_text.xml";
    my $outfile ="$outpath/$filename.col";
    &print_edictor($file, $outfile);
}


   # @namelist=();    
   # my $paleofile = "$path/paleographic/$filename.xml";
   # &get_XML_content($paleofile);
   # print join "\n", @namelist;



#sub get_XML_content{
#
#my $file = $_[0];
#
# create a sub tree of the full document that only contains the body part
# and create an handler that extract the name parts
# 
# my $twig= new XML::Twig( twig_roots    => { 'body' => 1 },
#                                             
#                          twig_handlers => { 'name'=> \&h_name } ); 
# 
# $twig->parsefile( "$file");     
# }
# 
# 
# # simple handler that extracts text from an element                 
# sub h_name{ 
#   my( $tree, $elem)= @_;                      # handlers params are always
#                                                              # the twig and the element
#   my $string  = $elem->text;                # get the text of element           
#   push @namelist, $string;
#  }
#  

sub print_edictor{

my $file = $_[0];
my $outfile = $_[1];
my ($orig, $norm, $expand);
print "bla";
open (OUTFILE,">:encoding(UTF-8)", $outfile)  || die "can't open $outfile\n";
open (FILE,"<:encoding(UTF-8)", $file)  || die "can't open $file\n";
while(<FILE>)
{
	my $line = $_;

	if($line =~  /<\/fs>/)
	{  
	    print OUTFILE "$orig\t$norm\t$expand\n";
		$orig =$norm =$expand ="";
	}
			
    if($line =~ /<f name="(.*?)"><string>(.*)<\/string><\/f>/)
    {
    	my $type =$1;
    	my $token = $2;
    	if($type  eq "orig"){$orig = $token;}
        if($type  eq "PON"){$orig = $token;}
        if($type  eq "norm"){$norm = $token;}
        #irrelevant if($type  eq "sic"){}
        if($type  eq "exp"){$expand = $token;}
    }
     
    if($line =~ /<\/s>/){ print OUTFILE "<s>\n";  }
}
close(FILE);
close(OUTFILE);

}     
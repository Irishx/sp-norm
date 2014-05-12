use utf8;
    

#binmode(STDIN, ":encoding(utf8)"); #actually check if it is UTF-8


#example input
#<seg xml:id="seg_17">
#               <fs type="edited">
#                  <f name="orig"><string>Porq</string></f>
#                  <f name="exp"><string>Porque</string></f>
#                 <f name="norm"><string>porque</string></f>
#              </fs>


$file = $ARGV[0];
open (FILE,"<:encoding(UTF-8)", $file)  || die "can't open $file\n";
while(<FILE>)
{
	$line = $_;
	
	if($line =~ /<\/s>/){ print OUTFILE "<s>\n";  }
	
	if($line =~ /<fs /)
	{  
	    binmode(STDOUT, ":encoding(UTF-8)");
	    print STDOUT "$orig\t$norm\t$expand\n";
		$orig =$norm =$expand ="";
	}
		
    if($line =~ /<f name="(.*?)"><string>(.*)<\/string><\/f>/)
    {
    	$type =$1;
    	$token = $2;
    	if($type  eq "orig"){$orig = $token;}
        if($type  eq "PON"){$orig = $token;}
        if($type  eq "norm"){$norm = $token;}
        #irrelevant if($type  eq "sic"){}
        if($type  eq "exp"){$expand = $token;}
    }
     
    
}
close(FILE);     
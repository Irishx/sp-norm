#irs, May 2014

# convert the  column format to VARDS format.
# for this round we decided  to ignore the abbreviations
# that means that the special cases where an abbreviation is first expanded and then normalized, are removed from evaluation!!
#all of these are ignored:

#NormColTrain/PS6223.col:ms		muchos
#NormColTrain/PS6223.col:as		años
#NormColTrain/PS6223.col:q		que
#NormColTrain/PS6216.col:ll	libras	llibras
#NormColTrain/PS6218.col:unicamte	únicamente	unicamente

#$file = $ARGV[0];
$path= "/Users/irishendrickx/CLUL/CARDS/Data/Spaans/mei2014/";
#@files = glob("$path/NormColTrain/*.col"); #Test


foreach $file (@files)
{
	chomp($file);
	if($file =~ /.*\/(.*)\.col/){ $name = $1; } 

	#open (OUT,">$path/VARDtrain/$name.txt") || die "kan niet schrijven";
	open(FILE, "$file")|| die "cant open $file\n";
	while(<FILE>)
	{
  		$line =$_;
  		chomp $line;
  		if($line =~ /<s>/){print OUT "\n"; }
  		else{
  	
        		($orig,$norm,$expand ) = split /\t/, $line;
        		if($expand eq "" && $norm eq  "")  {print OUT "$orig "; }     
        		else{
            			$printorig="";
         				if($expand ne ""){ $printorig = $expand;  }
         				if($norm ne "" ){ $printorig = $norm;  }
            			print OUT "<normalised orig=\"$orig\" auto=\"false\">$printorig<\/normalised> "; 
            	 }
      
  			}
 	
 	}	
close(FILE);
close(OUT);
}
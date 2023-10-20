BEGIN {
    FS = "|";           # Set the field separator to a comma
    OFS = "|";          # Set the output field separator to a comma
    
    ID = id
    COLLUMN = column
    VALUE = value

    #printf "\n\n%d,%s,%s\n", ID,COLLUMN,VALUE

}


# Process the first line (NR == 1)
NR == 1 {
    
    # Create an array to store the columns
    for (i = 1; i <= NF; i++) {
        columns[i] = $i
        #printf "%s\n", columns[i] 
    }

    

}


NR > 1 {                # Skip the header line


    id = $1


    if (ID == id) {
        
	        for (i = 2; i <= NF; i++) {

        		if ( COLLUMN == columns[i] ){
                    #printf "\n\n%s,%s,%d\n", $i,VALUE,i
        			$i = VALUE #Change column $i with the given value
                    #printf "\n\n%s\n", $i
        		}

    		}
    }

}

# Print the modified row
{
    print $0
}

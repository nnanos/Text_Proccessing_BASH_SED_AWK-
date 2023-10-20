BEGIN {
    FS = "|";           # Set the field separator to a comma
    OFS = "|";          # Set the output field separator 
}

NR > 1 {                # Skip the header line
    socialMedia = $9     # Get the socialMedia from the 9nth field


    # Increment the department count and add the salary
    socialMedia_count[socialMedia]++

}

END {

    # Iterate over socialMedia_count array and print socialMedia,socialMedia_count
    for (socMed in socialMedia_count) {
        printf "%s\t\t%d\n", socMed, socialMedia_count[socMed]
    }
}

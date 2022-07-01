Solution for part 1 is quite simple. I had to iterate through all lines of input.txt while
counting its total size and in memory size. Total size was just its length. In memory size required
to check each char in string. If it was a backslash then I checked next char. If the next char was an 'x' that
would mean a hexadecimal number would follow, so I can skip next 3 chars. If not then it had to be either a " or
\. In that case I had to skip only one char.

Part 2 was even simpler. Total size counting remained the same, but in memory size got replace by encoded size. 
It has only required to check string for \ and ". If such a char was found then I increased totalEncodedSize. After 
checking the string totalEncodedSize was further increased by line's length as all of its chars had to be encoded and 
an additional 2 for the surrounding quotes.
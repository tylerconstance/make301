# make301

A quick script I wrote at work to generate a list of 301 redirects from a .csv a client provided.

Tcl is a powerful scripting language that's great for doing lots of stuff with little code, and it ships with Mac OS! You can access the shell by typing "tclsh" to play around.

This script parses a file called "errors.csv" and outputs a file called "301-fix.txt" in the same directory.
 
Future modifications could allow for users to specify arguments from the command line, and could use a nonspecific regsub string for easier reusability (the client is currently hard-coded in the regsub string). I imagine I'll implement these changes the next time I get to use it!

To use:
Update the proper [lindex] values for uri and newUrl

Change the regsub command to substitute the proper uri for the redirects
Use the proper "puts" command for the rewrite rule style

a) open terminal and enter "tclsh make301.tcl"

or

b) open terminal and enter "chmod u+x make301.tcl" to give the user permission to execute the file, then just type "./make301.tcl" to run the file in the command line.

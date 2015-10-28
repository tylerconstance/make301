#!/usr/bin/tclsh
package require csv

# Script to parse a CSV for 301 redirects
# Coded on 21 Oct 2015 by Tyler Constance
#
# This script parses a file called "errors.csv" and outputs a file called "301-fix.txt" in the same directory
# Future modifications could allow for users to specify arguments from the command line, and could use a better regsub string
#
# To use:
# Change the regsub command to substitute the proper uri for the redirects
# Use the proper "puts" command for the relevant rewrite rule style (Redirect 301 or RewriteRule – I don't know if it matters)
#
# a) open terminal and enter "tclsh make301.tcl"
# or
# b) open terminal and enter "chmod u+x make301.tcl" to give the user permission to execute the file,
#    then just type "./make301.tcl" to run the file in the command line.

# Open file for reading, read contents, and close file
set file [open "errors.csv" r]
puts "\nReading the file ..."
set file_data [read $file]
close $file

# Create file for writing
set writeTo [open "301-fix.txt" w]

set list [::csv::split $file_data "\n"]

puts "Working some magic ..."
foreach i $list {
  set list [split $i ","]
  set uri [lindex $list 0]
  # remove whitespace
  set uri [regsub -all " " $uri ""]
  set uri [regsub {http://www.meadowmere.com/} $uri ""]
  # Make sure the $uri isn't empty so you're not inadvertently redirecting your homepage
  if {$uri != ""} {
    set newUrl [lindex $list 7]
    set newUrl [regsub -all " " $newUrl ""]
    # Assign boolean to "query," and assign the string to queryString
    set query [regexp {\?.*$} $uri queryString]
    if $query {
      #remove query string from uri
      set uri [regsub {\?.*$} $uri ""]
      #remove the leading "?" from the query string
      set queryString [string trimleft $queryString ?]
      puts $writeTo "RewriteCond \%\{QUERY_STRING\} \^$queryString\$\nRewriteRule \^$uri\$ $newUrl\? \[R=301,L\]"
    } else {
      # puts $writeTo "Redirect 301 [lindex $list 0] [lindex $list 7]"
      puts $writeTo "RewriteRule \^$uri\$ $newUrl \[R=301,L\]"
    }
  }
}
close $writeTo
puts "\nDonezo.\n"

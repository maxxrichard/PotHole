#! /bin/bash
#07/06/18 A BASH script to collect EXIF metadata 
#07/06/18 create metadata directory, create text file output for each file, append basename, place output in metadata directory
#07/06/18 create script.log to verify processing of files and place in metadata directory 
#07/06/18 Author: Sandy Lynn Ortiz - Stanford University Libraries - Born Digital Forensics Lab
#08/21/18 TO RUN: Place the script in the working directory. The script will search sub-dir's.  Open a terminal window (command prompt) and navigate to the working directory i.e. cd /path/to/directory. Type ./SAA.sh and hit enter.  The script will take a few min to run (start with a small set of testing files), depending on the number of files. It will prompt you when it completes. Try different commands in place of EXIFTOOL per your need.  **This is a functioning prototype only - *Not* intended for production**
####################################################################################

######  testing codeblock, clean up last run #####
rm -rf ./metadata
echo -ne "\\n metadata directory cleaned! \\n\\n"
######  testing codeblock, clean up last run #####

#create variable current working directory
    CWD=$(pwd)
   
#create directory and create variable META to store path, create LOGFILE in META directory
    mkdir metadata
    cd metadata
    META=$(pwd)
    LOGFILE="$META/script.log"
    cd "$CWD"
    echo -ne "\\n Current working directory is: \\n" $CWD "\\n"

#create variable EXCL to exclude script file from processing 
    EXCL=$(basename "$0")
    echo -ne "\\n Exclude Script file from processing: " $EXCL "\\n\\n"
                                                                   
####################################################################################   

#search for jpg files in curr dir/subdir, ignore case, pipe(send output from cmd1 to cmd2) to chain of commands
#create EXIF text files in META dir (redirect output)
    echo -ne "\\n Processing EXIF metadata now... \\n\\n"
    find $(cd "$CWD") -depth -iname "*.jpg" | while read filename; do exiftool "$filename" > "$META"/"$(basename "$filename")"_"exif.txt"; 
    done

#TEST - create EXIF text files in META dir(redirect), print file STDOUT redirect/append to LOGFILE - TEST
    #echo -ne "\\n Processing EXIF metadata now... \\n\\n"
    #find $(cd "$CWD") -depth -iname "*.jpg" | while read filename; do exiftool "$filename" > "$META"/"$(basename "$filename")"_"exif.txt" 
    #printf "\\n $filename" >> "$LOGFILE"; done

####################################################################################                     

    echo -ne "\\n\\n Processing is finished! \\n\\n\\n"
    
####################################################################################

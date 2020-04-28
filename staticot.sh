#!/bin/bash

function print_centered {
     [[ $# == 0 ]] && return 1

     declare -i TERM_COLS="$(tput cols)"
     declare -i str_len="${#1}"
     [[ $str_len -ge $TERM_COLS ]] && {
          echo "$1";
          return 0;
     }

     declare -i filler_len="$(( (TERM_COLS - str_len) / 2 ))"
     [[ $# -ge 2 ]] && ch="${2:0:1}" || ch=" "
     filler=""
     for (( i = 0; i < filler_len; i++ )); do
          filler="${filler}${ch}"
     done

     printf "%s%s%s" "$filler" "$1" "$filler"
     [[ $(( (TERM_COLS - str_len) % 2 )) -ne 0 ]] && printf "%s" "${ch}"
     printf "\n"

     return 0
}

banner "Staticot"
#Reading user input
echo "Enter the file name you would like to analyze: "
read file_name

printf "\n"

echo "Enter the name you want for output file: "
read report_name
print_centered "Report as of $(date +'%m/%d/%Y')" > "$report_name".txt

#Finding md5sum
banner "MD5 Hash" >> "$report_name".txt

md5sum "$file_name" >> "$report_name".txt

printf "\n" >> "$report_name".txt

#Finding EXIF Data
banner "EXIF DATA" >>"$report_name".txt

exiftool "$file_name" >> "$report_name".txt

printf "\n" >> "$report_name".txt

#Finding strings
banner "Strings" >> "$report_name".txt

strings "$file_name" >> "$report_name".txt

#Finding Virustotal hits
banner "Virustotal hits" >> "$report_name".txt

md5sum "$file_name" | awk '{print $1}' > md5sum.txt && cat md5sum.txt | xargs -I {} curl -s -X POST 'https://www.virustotal.com/vtapi/v2/file/report' --form apikey="02d42f7a9dc3b3557c64c3979ff7fbd9e05f661f81bf85e1c16a8a3bbb59277c" --form resource="{}" | awk -F 'positives\":' '{print "VirusTotal Hits: " $2}' | awk -F ' ' '{print $1$2$3$6$7}' | sed 's|["}]||g' >> "$report_name".txt

cat md5sum.txt | xargs -I {} curl -s -X POST 'https://www.virustotal.com/vtapi/v2/file/report' --form apikey="02d42f7a9dc3b3557c64c3979ff7fbd9e05f661f81bf85e1c16a8a3bbb59277c" --form resource="{}" | sed 's|\},|\}\n|g' > virustotal.txt

sudo rm md5sum.txt

echo "Report has been generated and saved as $report_name.txt"
echo "Generated an additional report and saved as virustotal.txt"

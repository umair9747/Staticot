# Staticot
![Image of Staticot](https://i.ibb.co/W56jb97/Screenshot-from-2020-04-28-18-43-24.png)


## A BASH script to automate simple tasks related to static malware analysis. 

## Features
1.Find the md5 hash

2.Extract the EXIF Data

3.Extract the strings

4.Find the total virustotal hits

5.Make a combined report for the above as a txt file

6.Make a report containing the json data of the whole virustotal scan


I made this script today,expect more features to be added soon!

## Installation
* git clone https://github.com/umair9747/staticot.git
* cd staticot
* chmod +x setup.sh
* ./setup.sh

## Usage
The usage is pretty simple. Just type ./staticot.sh and it will ask you for the file name / file path as well as the name you want for your report [dont add extension].It will automatically generate the report in the working directory.Make sure to change the virustotal API in case you face any errors since the free API is restricted to 4 requests per minute.

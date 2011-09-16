#!/bin/bash
#author: Wesley Ellis (@tahnok on twitter)

screenshot='screenshot';
nano=`date '+%d-%m-%y-%N'`;
extension='.png';
file="$HOME/Desktop/$screenshot-$nano$extension";

sleep 3; scrot -s -b -q 0 $file;

curl -d username=YOURUSERNAME -d password=YOURPASSWORD -c imgur_cookie.txt http://api.imgur.com/2/signin;

TEXT=$(curl -F "image"=@"$file" -F "key"="9d67c345536acff4b53e81d0b11d8c59" --cookie imgur_cookie.txt http://api.imgur.com/2/account/images | grep -Eo '<[a-z_]+>http[^<]+'|sed 's/^<.\|_./\U&/g;s/_/ /;s/<\(.*\)>/\1:\ /');

zenity --info --title="Imgur Upload" --text="$TEXT";

exit 0

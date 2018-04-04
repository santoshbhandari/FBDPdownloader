#!/bin/bash
if [[ "$1" != "-from" ]]; then
   echo "usage:"
   echo "-------"
   echo "grabfbpics -from [starid] [endid]"
   echo "grabfbpics -friendsid [id]"
   echo ""
   exit
fi

for (( i=$2; i<=$3; i++  )); do
	response=$(curl -sI "https://graph.facebook.com/$i/picture?width=64&height=64")
        validate=$(echo $response | grep 'Location')
        if [ "$validate" != "" ]; then
		final=$(echo "$response" | grep Location | awk '{print $2}')
                URL=${final%$'\r'}
                echo "Downloading a profile picture with a user id $i"
                curl -s "$URL" >> "images/"$i.jpg
	fi

        if [ "$validate" == "" ]; then
             echo "Facebook user with id $i does not exist"
        fi
done

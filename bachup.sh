#!/bin/bash

function dirsend(){
	echo started copying $1 directory
	smbclient '\\server\share' -U user%password -d 0 -c "prompt OFF; recurse ON; cd \"startic/destdir/\"; mkdir \"$2\"; cd \"$2\"; lcd \"$1\"; mput *" && echo && echo finished copying $1 directory
	}

cd ~

echo Started file copy to SMB server

time dirsend /etc/apt apt&

for dir in Music Pictures Videos Arduino Documents; do time dirsend $dir $dir& done

wait

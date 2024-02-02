#!/bin/bash

Today="$(date +%F)"

echo This backup\'s date is $Today

function smbcommand(){
	smbclient '\\server\share' -U user%password -c "$@"
}

smbcommand "prompt OFF; cd \"startic/destdir/\"; mkdir $Today"

function dirsend(){
	echo started compressing $1 directory
	tar cfh - $1 | xz -zfT 0 - > /compressed/files/dir/$2.tar.xz && echo finished compressing $1 directory && smbcommand "prompt OFF; cd \"startic/destdir/$Today\"; lcd \"/compressed/files/dir/\"; put $2.tar.xz"
}

cd ~

echo Started file copy to SMB server

time dirsend /etc/apt apt&

for dir in Music Pictures Videos Arduino Documents; do time dirsend $dir $dir& done

wait

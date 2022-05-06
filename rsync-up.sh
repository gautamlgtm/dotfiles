#!/bin/bash
echo " you are currently in $PWD"

LOCAL_EP_SSH_SCRIPTS_BASE="$HOME/easypost/ssh-scripts"
#check exclude list
echo "local ep base path: $LOCAL_EP_SSH_SCRIPTS_BASE"

#check exclude file exists:
echo "checking that exclude file list exists..."
cat "$LOCAL_EP_SSH_SCRIPTS_BASE/exclude_list.txt"
echo "........................................."

if [ -n "$LOCAL_EP_SSH_SCRIPTS_BASE" ]; then
	EXCLUDE_OPTS=$(cat "$LOCAL_EP_SSH_SCRIPTS_BASE/rsync_exclude_list.txt")
	echo "files to exclude: $EXCLUDE_OPTS"
else
	echo "No files to be excluded during sync"
fi

#check ep path and rsync to devbox
DEV_VM="gautams-dev-vm.gpappu.devvm.easypo.net"
EP_PATH=$(pwd | grep -o 'easypost/[A-Za-z-]*$')
echo "Your easypost path $EP_PATH"
if [ -n "$EP_PATH" ]; then
	echo "DEV_VM HOST: $DEV_VM"
	echo "Path to rsync to: /home/vagrant/$EP_PATH"
	fswatch -0 -o -e .git/ -e .pyc . |	rsync -ahzrvP -v --stats --progress --exclude="$EXCLUDE_OPTS" -e "ssh -p 22 -i $HOME/.ssh/id_rsa" "$HOME/$EP_PATH" "vagrant@$DEV_VM:/home/vagrant/$EP_PATH" > "$HOME/rsync.log" 2>&1
else
	echo "No match for EasyPost rsync"
	tail -f "$HOME/rsync.log"
fi

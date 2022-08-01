MOUNTPOINT=${HOME}/remote-vm
mkdir -p ${MOUNTPOINT}

if mount | grep "on ${MOUNTPOINT}" > /dev/null; then
    diskutil   unmount force ${MOUNTPOINT}
fi

ssh-add -A
sshfs -C -o compression=yes -o auto_cache,noappledouble,nolocalcaches,no_readahead,defer_permissions,IdentityFile=~/.ssh/id_rsa,volname=VM vm: ${MOUNTPOINT}

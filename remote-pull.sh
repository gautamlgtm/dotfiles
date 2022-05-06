
#!/bin/bash
# syncs the default EC2 instance to current project (as defined by git repo)

# get the path to the project root (where the .git folder is)
project_path=`git rev-parse --show-toplevel 2> /dev/null`

if [ $? -eq 0 ]; then

    # name of the project folder
    project_name=`basename $project_path`

    # rsync from server ~/projects/project-name
    rsync -avL --cvs-exclude --progress \
        # ignore the push-only folders
        --exclude=/code --exclude=/scripts --exclude=/docs \
        -e "ssh" $1 \
        vagrant@gautams-dev-vm.gpappu.devvm.easypo.net:projects/$project_name/ $project_path
fi

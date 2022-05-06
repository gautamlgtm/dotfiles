
#!/bin/bash
# syncs the current project (as defined by git repo) to default EC2 instance

# get the path to the project root (where the .git folder is)
project_path=`git rev-parse --show-toplevel 2> /dev/null`

if [ $? -eq 0 ]; then

    # name of the project folder
    project_name=`basename $project_path`

    # rsync to server ~/projects/project-name
    rsync -avL --progress \
        # ignore the pull-only folders
        --exclude=/notebooks --exclude=/results \
        -e "ssh" $1 \
        $project_path gautams-dev-vm.gpappu.devvm.easypo.net:projects
fi

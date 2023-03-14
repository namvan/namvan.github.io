Original text from here <https://stackoverflow.com/questions/6865302/push-local-git-repo-to-new-remote-including-all-branches-and-tags>

There is no single command but same command should be called twice.

    git push <remote alias> --all
    git push <remote alias> --tags

remote alias is something like origin.

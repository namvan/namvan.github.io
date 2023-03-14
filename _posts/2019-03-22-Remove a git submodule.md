Extracted from here <https://riptutorial.com/git/example/2652/removing-a-submodule>

This action would require 2 commands

    git submodule deinit the_submodule
    git rm the_submodule

The first command deletes the entry of the_submodule from .git/config. This will exclude the_submodule from any subsequence git submodule commands. The command also makes the_submodule folder as Uninitialized.
This will not be shown as change in the current (parent) repository.

The second comannd removes the_submodule from the working tree. The files will be gone as well as the entry in the .gitmodules file.
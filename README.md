

## Tooling is a collection of useful scripts and handy programs for life with (debian-based) linux.

#### Setup Scripts
- config-apt-puzzle.sh
- program-list.txt
  - runing 'config-apt-puzzle.sh' will install all programs from program-list.txt
- config-git-puzzle.sh
- git-list.txt
  - runing 'config-git-puzzle.sh' will configure my committer and author details for git. One day it will also download repositories from git-list.txt to "~/x".

#### Miscelanious
- load-config.sh
  - Sets up "~/x" and clones a new version of itself. It then copies xmonad config from tooling to the live user directory.
- save-config.sh <MSG>
  - Copies all the xmonad config files from the running system to the "~/x/Tooling" directory and makes a commit with the supplied log message. It then reminds you to push the commit.
- README.md
  - Your here.

#### Directories
- bash
  - fun scripts
- home
  - xmonad config

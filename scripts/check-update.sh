#!/usr/bin/env bash
set -ex

MODNAME="EdBPrepareCarefully"

BASEDIR="$HOME/git"
ENG_DIR="$BASEDIR/$MODNAME"
FR_DIR="$BASEDIR/$MODNAME-fr"
RELEASE_DIR="$HOME/.steam/steam/steamapps/common/RimWorld/Mods/"

# 1. Refresh upstream git depot
cd $ENG_DIR
git fetch upstream

# 2. Show last diff
git difftool -y master..upstream/master -- Resources/Languages/English/Keyed/EdBPrepareCarefully.xml &

# 3. Open all git tools in $FR_DIR
cd $FR_DIR
# gitk --all &
# git gui &

# 4. Open for edition
kate About/*.xml Languages/French/Keyed/EdBPrepareCarefully.xml &

# 5. commit and push modification to (EdBPrepareCarefully)upstream/master and origin/master


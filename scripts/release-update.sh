#!/usr/bin/env bash
set -ex

MODNAME="EdBPrepareCarefully"

BASEDIR="$HOME/git"
ENG_DIR="$BASEDIR/$MODNAME"
FR_DIR="$BASEDIR/$MODNAME-fr"

RELEASE_DIR="$HOME/.steam/steam/steamapps/common/RimWorld/Mods/"

# 1. Update file in RimWorld-fr  
cd $FR_DIR
# Validate all xml files
find . | grep xml | xargs xmllint --noout
#cp --update "Languages/French/Keyed/$MODNAME.xml" "Languages/RimWorld-fr/Keyed/$MODNAME.xml"
rm -Rf "Languages/RimWorld-fr/"

# 2. Create zip archive
[ -d "Archives" ] || mkdir "Archives"
if [ -f "Archives/$MODNAME-fr.zip" ] ; then
  LASTMODIFICATION="$(date +"%F-%H-%M-%S" -r Archives/$MODNAME-fr.zip)"
  cp "Archives/$MODNAME-fr.zip" "Old-Archives/$MODNAME-fr-$LASTMODIFICATION.zip"
  rm -f "Archives/$MODNAME-fr.zip"
fi

cd $BASEDIR
zip -r "$MODNAME-fr/Archives/$MODNAME-fr.zip" \
  "$MODNAME-fr/About" \
  "$MODNAME-fr/Languages" \
  "$MODNAME-fr/README.md"
  
# 3. Copy all files to $RELEASE_DIR

# NOTE: May be better use extended glob to exclude some dirs like this ?
# shopt -s extglob
# cp --update -R "$MODNAME-fr/!(Old-Archives | scripts | .git)" "$RELEASE_DIR"

cp --update -R "$MODNAME-fr/" "$RELEASE_DIR"
# clean up
rm -Rf "$RELEASE_DIR/$MODNAME-fr/Old-Archives"
rm -Rf "$RELEASE_DIR/$MODNAME-fr/scripts"
rm -Rf "$RELEASE_DIR/$MODNAME-fr/.git"
rm -f "$RELEASE_DIR/$MODNAME-fr/.gitignore"
rm -f "$RELEASE_DIR/$MODNAME-fr/Archives/"*.gz
cd $FR_DIR

# 4. Test in game

# 5. Commit and push modification to (EdBPrepareCarefully-fr)origin/master
# git push origin/master

# 6. Create release on github, push to Steam Workshop


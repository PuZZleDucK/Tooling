#/bin/bash

GIT_REPO="https://github.com/PuZZleDucK/Tooling.git"

echo " == Saving BootStrap Config == "
echo "User: $USER"
echo "Pushing to: $GIT_REPO"
echo "Git Dir: $HOME/x/Tooling/"
echo "Commit message: $@"
echo ""

read -p "<ctrl>-c to cancel, enter to proceed..."

if [ -d "$HOME/x/Tooling" ]; then
  echo "Git dir found"
else
  echo "Error"
fi


# Xmonad
cp "$HOME/.db-status.sh" "$HOME/x/Tooling/home/"
cp "$HOME/.volume.sh" "$HOME/x/Tooling/home/"
cp "$HOME/.xmobarrc" "$HOME/x/Tooling/home/"
cp "$HOME/.xmobarrc2" "$HOME/x/Tooling/home/"
cp "$HOME/.xmonad/xmonad.hs" "$HOME/x/Tooling/home/.xmonad/"


LOG=$@
echo "LOG: $LOG :GOL"
# Commit update
pushd "$HOME/x/Tooling"
 git add -A
 git commit -m "SAVE:$LOG"

# Push update
 echo "push..."
popd



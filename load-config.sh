#/bin/bash

GIT_REPO="https://github.com/PuZZleDucK/Tooling.git"

echo " == BootStrap Tooling == "
echo "User: $USER"
echo "Getting config from: $GIT_REPO"
echo "Into Target Dir: $HOME/x"
echo ""

read -p "<ctrl>-c to cancel, enter to proceed..."

if [ -d "$HOME/x" ]; then
  echo "# Load config found x directory: $HOME/x" | tee "$HOME/x/log.md"
else
  mkdir "$HOME/x"
  echo "# Load: Installing x directory: $HOME/x" | tee "$HOME/x/log.md"
fi

# Clone toolset or update
if [ -d "$HOME/x/Tooling" ]; then
  cd "$HOME/x/Tooling"
  echo "Updating config"
  git pull origin master
else
  git clone $GIT_REPO
fi
cd "$HOME/x/Tooling"

# Xmonad
cp "home/.db-status.sh" ~/
cp "home/.volume.sh" ~/
cp "home/.xmobarrc" ~/
cp "home/.xmobarrc2" ~/
if [ -d "$HOME/.xmonad" ] ; then
  echo "Found old .xmonad dir."
else
  mkdir "$HOME/.xmonad/"
  echo "Generated .xmonad dir."
fi
cp "home/.xmonad/xmonad.hs" "$HOME/.xmonad/"







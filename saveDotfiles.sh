cd ~/Dotfiles || { echo "Failed cd" ; exit ; };
git add .;
git commit -m "New";
git push -u origin main;

#!/usr/bin/env fish

# cd and ls
function cs
  cd $argv[1]
  # pwd
  ls -al
end

# mv, create dir if DNE
function move
  mkdir -p $argv[3]
  mv $argv[2] $argv[3]
end

### Git functions
function ship
  git add -A
  git commit -am $argv
  git push
end
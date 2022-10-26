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

# rm all except
function keep
  set -l files *
  for keeper in $argv
      set -l keeper (string trim -r -c / $keeper)
      if set -l index (contains -i -- $keeper $files)
          set -e files[$index]
      end
  end
  rm -rf $files
end

### Git functions
function ship
  git add -A
  git commit -am $argv
  git push
end

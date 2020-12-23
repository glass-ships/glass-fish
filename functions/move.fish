# mv, create dir if DNE
function move
  mkdir -p $argv[3]
  mv $argv[2] $argv[3]
end

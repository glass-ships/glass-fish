# build cpp (with awkward)
function gpp-awk
  g++ -I/opt/awkward-1.0/include -L/opt/awkward-1.0/build/lib.linux-x86_64-3.7/awkward1 $argv[1] -lawkward-static -lawkward-cpu-kernels-static -o $argv[2]
end

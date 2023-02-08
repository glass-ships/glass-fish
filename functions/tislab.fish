### TISLAB functions

function test-koza
    cd ~/dev/TISLAB/koza/
    poetry build 
    cd ~/dev/TISLAB/monarch-ingest 
    poetry run pip uninstall koza -y
    poetry run pip install ~/dev/TISLAB/koza/dist/koza-0.2.3-py3-none-any.whl 
end
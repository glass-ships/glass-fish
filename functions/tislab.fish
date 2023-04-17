### TISLAB functions

alias mdocs='cd ~/dev/TISLab/monarch-technical-documentation'
alias mpy='cd ~/dev/TISLab/monarch-py'
alias mapp='cd ~/dev/TISLab/monarch-app'
alias mingest='cd ~/dev/TISLab/monarch-ingest'
alias mui='cd ~/dev/TISLab/monarch-ui'

function test-koza
    cd ~/dev/TISLab/koza/
    poetry build 
    cd ~/dev/TISLab/monarch-ingest 
    poetry run pip uninstall koza -y
    poetry run pip install ../koza/dist/koza-0.3.0-py3-none-any.whl
end
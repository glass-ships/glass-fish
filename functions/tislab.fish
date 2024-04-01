### TISLAB functions

# cd shortcuts

alias mdocs='cd ~/dev/TISLab/monarch-documentation'
alias mapp='cd ~/dev/TISLab/monarch-app'
alias mingest='cd ~/dev/TISLab/monarch-ingest'
alias mkoza='cd ~/dev/TISLab/koza'
alias mmapping='cd ~/dev/TISLab/monarch-mapping-commons'
alias mstack='cd ~/dev/TISLab/monarch-stack-v3'

# common command chains

function test-koza
    cd ~/dev/TISLab/koza/
    poetry build 
    cd ~/dev/TISLab/monarch-ingest 
    poetry run pip uninstall koza -y
    poetry run pip install ../koza/dist/koza-0.5.4-py3-none-any.whl
end

function fix-solr-perms
    sudo chgrp -R 8983 /home/glass/.data/monarch 
    sudo chmod -R g+w /home/glass/.data/monarch
end
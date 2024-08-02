### TISLAB functions

# cd shortcuts

abbr -a mdocs 'cd ~/dev/TISLab/monarch-documentation'
abbr -a mapp 'cd ~/dev/TISLab/monarch-app'
abbr -a mingest 'cd ~/dev/TISLab/monarch-ingest'
abbr -a mkoza 'cd ~/dev/TISLab/koza'
abbr -a mmapping 'cd ~/dev/TISLab/monarch-mapping-commons'
abbr -a mstack 'cd ~/dev/TISLab/monarch-stack-v3'

# common command chains

function test-koza
    cd ~/dev/TISLab/koza/
    poetry build 
    cd ~/dev/TISLab/monarch-ingest 
    poetry run pip uninstall koza -y
    poetry run pip install ../koza/dist/koza-0.5.4-py3-none-any.whl
end

function dev-catmerge
    cd ~/dev/TISLab/cat-merge/
    poetry build 
    cd ~/dev/TISLab/monarch-ingest 
    poetry run pip uninstall cat-merge -y
    poetry run pip install ../cat-merge/dist/cat_merge-0.2.2-py3-none-any.whl
end

function fix-solr-perms
    sudo chgrp -R 8983 /home/glass/.data/monarch 
    sudo chmod -R g+w /home/glass/.data/monarch
end
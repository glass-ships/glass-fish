### TISLAB functions

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
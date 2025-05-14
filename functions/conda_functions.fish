# function venv_activate --on-variable PWD -d "activate conda env/venv on cd"
#     if [ -f (pwd)/.condaconfig ]
#         set -gx VENVDIR (pwd)
#         conda activate (cat .condaconfig)
#     else if [ -f (pwd)/.mambaconfig ]
#         set -gx VENVDIR (pwd)
#         mamba activate (cat .mambaconfig)
#     else if [ -f (pwd)/.venv/Scripts/activate ]
#         set -gx VENVDIR (pwd)
#         source (pwd)/.venv/Scripts/activate
#     else if [ -f (pwd)/.venv/bin/activate ]
#         set -gx VENVDIR (pwd)
#         source ./.venv/bin/activate
#     else if [ "$VENVDIR" ]
#         # Check if the current directory is not in the VENVDIR path
#         if not [ (string match "*$VENVDIR*" (pwd)) ]
#             set -e VENVDIR
#             conda deactivate
#             # mamba deactivate
#             # Check if the current directory is not in the VENVDIR path
#             if not [ (string match "*$VENVDIR*" (pwd)) ]
#                 set -e VENVDIR
#                 conda deactivate
#                 # mamba deactivate
#             end
#         end
#         if not [ (string match "*$VENVDIR*" (pwd)) ]
#             set -e VENVDIR
#             conda deactivate
#         end

#     end
#     if not [ (string match "*$VENVDIR*" (pwd)) ]
#         set -e VENVDIR
#         mamba deactivate
#     end
# end


function venv_activate --on-variable PWD -d "activate conda env/venv on cd"
    if [ -f (pwd)/.condaconfig ]
        set -gx VENVDIR (pwd)
        conda activate (cat .condaconfig)
    else if [ -f (pwd)/.mambaconfig ]
        set -gx VENVDIR (pwd)
        mamba activate (cat .mambaconfig)
    else if [ -f (pwd)/.venv/Scripts/activate ]
        set -gx VENVDIR (pwd)
        source ./.venv/Scripts/activate
    else if [ -f (pwd)/.venv/bin/activate.fish ]
        set -gx VENVDIR (pwd)
        source ./.venv/bin/activate.fish
    end
    if not [ (string match "*$VENVDIR*" (pwd)) ]
        set -e VENVDIR
        deactivate
        conda deactivate
        # mamba deactivate
    end
end


# function conda_activate --on-variable PWD -d "activate conda env"
#     if [ -f (pwd)/.condaconfig ]
#         set -gx CONDACONFIGDIR (pwd)
#         conda activate (cat .condaconfig)
#     end
#     if not [ (string match "*$CONDACONFIGDIR*" (pwd)) ]
#         set -e CONDACONFIGDIR
#         conda deactivate
#     end
#     if [ -f (pwd)/.mambaconfig ]
#         set -gx MAMBACONFIGDIR (pwd)
#         mamba activate (cat .mambaconfig)
#     end
#     if not [ (string match "*$MAMBACONFIGDIR*" (pwd)) ]
#         set -e MAMBACONFIGDIR
#         mamba deactivate
#     end
# end


function install-miniforge -d "install miniforge"
    # Install Miniforge
    wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-(uname)-(uname -m).sh
    bash Miniforge3-(uname)-(uname -m).sh
end


function uninstall-miniforge -d "uninstall miniforge"
    if not [ (count $argv) -eq 0 ] && [ $argv[1] = check ]
        conda init --reverse --dry-run
        return
    else
        conda init --reverse
    end
    set CONDA_BASE_ENVIRONMENT (conda info --base)
    echo The next command will delete all files in {$CONDA_BASE_ENVIRONMENT}.
    set -l response (read -l -P "Continue? [y/n]")
    if not string match -q "y*" -- string lower $response
        echo "Aborting..."
        return
    end
    echo Deleting {$CONDA_BASE_ENVIRONMENT}
    rm -rf {$CONDA_BASE_ENVIRONMENT}
    echo {$HOME}/.condarc will be removed if it exists
    rm -f "{$HOME}/.condarc"
    echo {$HOME}/.conda and underlying files will be removed if they exist.
    rm -fr {$HOME}/.conda
    echo "Uninstall complete."
end

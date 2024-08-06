function cd -d "cd with auto conda activation"
    builtin cd $argv ;;
    if test -f (pwd)/.condaconfig
        set -gx CONDACONFIGDIR (pwd)
        conda activate (cat .condaconfig)
    else if [ -n "$CONDACONFIGDIR" ]
        if [ -n (string match -q -- "*$CONDACONFIGDIR*" (pwd)) ]
            set -gx CONDACONFIGDIR ""
            conda deactivate
        end
    end
end
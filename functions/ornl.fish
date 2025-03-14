### cd shortcuts ###

abbr -a cdbumps 'cd ~/dev/ornl/bumps'
abbr -a cdr1d 'cd ~/dev/ornl/refl1d'
abbr -a cdref 'cd ~/dev/ornl/RefRed'
abbr -a cdlr 'cd ~/dev/ornl/LiquidsReflectometer'
abbr -a cdsans 'cd ~/dev/ornl/drtsans'
abbr -a cdlds 'cd ~/dev/ornl/live_data_server'
abbr -a cdmantid 'cd ~/dev/ornl/mantid'

function dev-lr -d "Install local copy of LiquidsReflectometer"
    echo "Installing local copy of LiquidsReflectometer..."
    cd ~/dev/ornl/RefRed
    pip uninstall lr_reduction -y
    cd ~/dev/ornl/LiquidsReflectometer
    conda activate refred
    pip install -e .
    cd -
end

### Refl1D shortcuts ###

function linkbumps -d "Link bumps to the refl1d directory"
    cd ~/dev/ornl/bumps/bumps/webview/client
    bun install
    bun link
    cd ~/dev/ornl/refl1d/refl1d/webview/client
    bun link bumps-webview-client
end

### Mounting analysis server ###

function mount-hfir -d "Mount /HFIR from analysis cluster"
    echo "Mounting /HFIR..."
    mkdir -p ~/dev/ornl/analysis/HFIR
    sshfs ge2@analysis.sns.gov:/HFIR ~/dev/ornl/analysis/HFIR # -o defer_permissions,volname=HFIR
end 

function mount-sns -d "Mount /SNS from analysis cluster"
    echo "Mounting /SNS..."
    mkdir -p ~/dev/ornl/analysis/SNS
    sshfs ge2@analysis.sns.gov:/SNS ~/dev/ornl/analysis/SNS
    # sshfs ge2@analysis.sns.gov:/SNS /
    # if test (count $argv) -ne 1
    #     echo "Usage: mount-sns <instrument>"
    #     return 1
    # end

    # set inst $argv[1]
    # echo "Mounting analysis server for $inst..."
    # mkdir -p ~/dev/ornl/analysis/SNS/$inst
    # sshfs ge2@analysis.sns.gov:/SNS/$inst/ ~/dev/ornl/analysis/SNS/$inst # -o defer_permissions,volname=$inst
end

function unmount-analysis -d "Unmount the mountpoint for analysis server for given instrument"
    if test (count $argv) -ne 1
    #     echo "Usage: unmount-sns <instrument>"
        echo "Usage: unmount-analysis HFIR|SNS"
        return 1
    end
    echo "Unmounting analysis server for $argv[1]..."
    fusermount3 -u ~/dev/ornl/analysis/$argv[1]
    # set inst $argv[1]
    # echo "Unmounting analysis server for $inst..."
    # fusermount3 -u ~/dev/ornl/analysis/SNS/$inst
end

### VPN shortcuts ###

function vpn -d "Connect/Disconnect to ORNL VPN/show status"
    if test (count $argv) -ne 1
        echo "Usage: vpn [connect|disconnect|status]"
        return 1
    end

    if [ $argv[1] = connect ]
        echo "Connecting to ORNL VPN..."
        globalprotect connect -p vpn.ornl.gov
    else if [ $argv[1] = disconnect ]
        echo "Disconnecting from ORNL VPN..."
        globalprotect disconnect
    else if [ $argv[1] = status ]
        echo "VPN Status:"
        globalprotect show --status
    else
        echo "Usage: vpn [connect|disconnect|status]"
        return 1
    end
end

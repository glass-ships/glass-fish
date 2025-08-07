### Mantid shortcuts ###

function build-mantid -d "Build Mantid from source"
    echo "Building Mantid..."
    cd ~/dev/ornl/mantid
    cmake --preset=linux -B ~/dev/ornl/_builds/mantid
end

function test-mantid -d "Run Mantid tests"
    echo "Running Mantid tests..."
    cd ~/dev/ornl/_builds/mantid
    mamba activate mantid-developer
    ninja AllTests
end

### Reflectometry shortcuts ###

function dev-lr -d "Install local copy of LiquidsReflectometer"
    echo "Installing local copy of LiquidsReflectometer..."
    cd ~/dev/ornl/RefRed
    pip uninstall lr_reduction -y
    cd ~/dev/ornl/LiquidsReflectometer
    micromamba activate refred
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

function mount-analysis -d "Mount the analysis server directory for given instrument"
    if test (count $argv) -ne 1
        echo "Usage: mount-analysis <dir to mount>"
        echo "Example: mount-analysis sns"
        return 1
    end
    # set inst (string upper $argv[1])
    set inst $argv[1]
    echo Mounting analysis server for $inst...
    mkdir -p ~/dev/ornl/analysis/$inst
    sshfs ge2@analysis.sns.gov:/$inst ~/dev/ornl/analysis/$inst # -o defer_permissions,volname=$inst
end

function unmount-analysis -d "Unmount the mountpoint for analysis server for given instrument"
    if test (count $argv) -ne 1
        echo "Usage: unmount-analysis HFIR|SNS"
        return 1
    end
    # set inst (string upper $argv[1])
    set inst $argv[1]
    echo Unmounting analysis server for $inst...
    fusermount3 -u ~/dev/ornl/analysis/$inst
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

# cd shortcuts

abbr -a cdlds 'cd ~/dev/ornl/live_data_server'
abbr -a cdmantid 'cd ~/dev/ornl/mantid'
abbr -a cdref 'cd ~/dev/ornl/refl1d'
abbr -a cdsans 'cd ~/dev/ornl/sans-backend'
abbr -a cdwebref 'cd ~/dev/ornl/web_reflectivity'


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

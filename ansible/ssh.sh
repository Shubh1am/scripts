
#!/bin/bash
##################SSH to multiple instances and end#####################
########
########
ip_addresses=("54.225.37.98" "34.230.22.49" "54.242.142.170")  # Replace with your IP addresses
commands=("ls -l")  # Replace with your desired commands

for ip in "${ip_addresses[@]}"; do
    ssh ubuntu@$ip <<EOF
        ${commands[@]}
        exit
EOF
done


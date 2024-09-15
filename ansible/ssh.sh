
#!/bin/bash
##################SSH to multiple instances and end#####################
########
########
ip_addresses=("13.201.89.53" "3.110.27.51" "65.0.107.51" "3.7.45.95")  # Replace with your IP addresses
commands=("ls -l")  # Replace with your desired commands

for ip in "${ip_addresses[@]}"; do
    ssh ubuntu@$ip <<EOF
        ${commands[@]}
        exit
EOF
done


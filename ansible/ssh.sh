
#!/bin/bash
##################SSH to multiple instances and end#####################
########
########
ip_addresses=("3.110.43.186" "15.207.71.234" "13.126.17.167" "15.206.148.12")  # Replace with your IP addresses
commands=("ls -l")  # Replace with your desired commands

for ip in "${ip_addresses[@]}"; do
    ssh ubuntu@$ip <<EOF
        ${commands[@]}
        exit
EOF
done


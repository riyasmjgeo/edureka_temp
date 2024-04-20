#!bin/bash

function cpu_load {
	uptime | awk '{print $8, $9}'
}

function memory_usage {
	free -m | awk '/Mem:/ {printf "%.2f%% used\n", ($3/$2)*100}'
}


function disk_usage {
	df -h / | awk '$NF=="/" {printf "%s used\n", $5}'
}

function network_usage {
	interface="enp0s3"
	rx_bytes=$(ifconfig $interface | grep "RX bytes:" | awk '{print $6}')
	tx_bytes=$(ifconfig $interface | grep "TX bytes:" | awk '{print $6}')

	printf "Receive: %s bytes/s\nTransmit: %s bytes/s\n" $rx_bytes $tx_bytes
}

function logged_in_users {
	who | awk '{print $1}' | sort | uniq -c | awk '{printf "%s users (%s)\n", $1, $2}'
}


echo "System information:"
echo "Memory usage: $(memory_usage)"
echo "CPU Load: $(cpu_load)"
echo "Disk usage (/): $(disk_usage)"
echo "Network usage: $(network_usage)"
echo "Logged users:"
logged_in_users


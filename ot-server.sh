#!/bin/bash
set -e
# This script opens multiple TCP servers, one on each port, and displays a message when a user connects.

# Check if the script is run as root (necessary for binding to ports below 1024)
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!"
   exit 1
fi

# Define an array of ports you want to listen on
PORTS=(1111 2222 3333 4444)  # List of ports

# Function to start a TCP server on a given port
start_server() {
    local port=$1
    while true; do
        # Start a TCP server using netcat and display message when a connection is made
	nc -l $port -k -c "echo 'New connection to $(hostname -I)($(hostname)) on port $port!'; cat"
    done
}

# Kill previous nc sessions
killall nc || true

# Loop through the list of ports and start a server on each one
for port in "${PORTS[@]}"; do
    echo "Starting server on port $port..."
    start_server $port &
done

# Wait for all background servers to finish (this will never happen, since they run indefinitely)
wait

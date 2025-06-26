# OT CyberArk Demo

This demonstration shows how one can perform TCP port forwarding to OT systems using CyberArk Secure Infrastructure Access.

## Prerequisites
- CyberArk Platform
- SIA service provisionned to the platform
- SIA Administrator access (granted by the role DPAAdmin)
- SIA Client connector deployed in your environment
- Linux Server with root access

## Installation

### Create an access policy (SIA Admin)
On the SIA server, create a local account with no permissions (eg: ot-operator).  
In SIA Administration, create a ZSP policy which authorizes users to connect to the SIA connector as ot-operator.  

### Configure the OT server (System Admin)
On the Linux server, deploy the `ot-server.sh` script and run as root:
```bash
# ./ot-server.sh
Starting server on port 1111...
Starting server on port 2222...
Starting server on port 3333...
Starting server on port 4444...
```

## Usage

### Connect to the target system (End User)
On your machine, open an ssh connection to SIA with port forwarding
```bash
$ ssh -T -L 1111:<target address>:1111 -L 2222:<target address>:2222 <username>#<tenant name>@<sia connector>@<tenant name>.ssh.cyberark.cloud
```
NB: In the command, replace the following with the real values:
 - `<target address>`: Address of the linux server running ot-server.sh
 - `<username>`: your username for log into the CyberArk platform
 - `<sia connector>`: address of the sia client connector
 - `<tenant name>`: name of your Cyberark instance (eg: example if the URL is example.cyberark.cloud)

### Test the port forwarding
```bash
$ telnet 127.0.0.1 1111
New connection to <ip> (<hostname>) on port 1111!
```


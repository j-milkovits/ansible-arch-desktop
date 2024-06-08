# Automation of desktop setup using Ansible
## Setup
### Setup with cloning
> recommend: provides intermediate feedback after every task 
1. Install Arch (Create User (wheel) | Setup Network)
2. Clone this repository and execute `install.sh`
```
chmod a+x install.sh && ./install.sh
```
3. Type in sudo password when prompted (`BECOME password:`)
4. Wait until the installation is finished
### Setup without cloning
> does not provide intermediate feedback after every step -> might feel like nothing is happening
1. Install Arch (Create User (wheel) | Setup Network)
2. Copy `install_remote.sh` to local system and execute it  
```
chmod a+x install_remote.sh && ./install_remote.sh
```
3. Type in sudo password when prompted (`BECOME password:`)
4. Wait until the installation is finished
## Testing
> currently performed using a archlinux container
1. Build the docker container using the Dockerfile
```
docker build <container_name> .
```
2. Start the docker container
```
docker run -it --rm <container_name> bash
```
3. Run the install script
```
./install.sh
```

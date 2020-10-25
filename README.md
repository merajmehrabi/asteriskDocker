# asteriskDocker
Dockerized Asterisk on alpine and standalone IP ( no NAT )



# Configure IPs
Please edit `.env` file and enter IP, gateway and subnet.

# Starting
Run `./start.sh` or `docker-compose up -d`

# Asterisk CLI
Run `./asteriskCli.sh`

# Asterisk Settings
Asterisk configs will be store in `./asterisk` folder, if you have your own settings you can copy that files in this directory, so the container will use that.

# Stoping and removing
Run `./stop.sh` or `docker-compose down`


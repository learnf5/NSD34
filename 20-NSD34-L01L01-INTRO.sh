# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update lab environment
# pull files from github
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/juice.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/hosts_jump
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/hosts_nginx

# prep directories on nginx and copy files to nginx
    sudo ssh nginx mkdir /etc/nginx/ssl
    sudo ssh nginx chown nginx:nginx /etc/nginx/ssl
    sudo ssh nginx mkdir /etc/nginx/ssl-configs

# copy files to nginx

    sudo ssh nginx rm /etc/nginx/conf.d/default.conf
    sudo scp /tmp/nsd_files/INTRO/hosts_nginx nginx:/etc/hosts
    sudo scp /tmp/nsd_files/INTRO/juice.conf  nginx:/etc/nginx/conf.d/juice.conf

# update local hosts file on jump system
    sudo mv /tmp/nsd_files/INTRO/hosts_jump /etc/hosts
 

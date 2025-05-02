# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update lab environment

# pull files from github
echo $COURSE_ID
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/juice.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/hosts_jump
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/hosts_nginx

# prep directories on nginx and copy files to nginx
    sudo ssh nginx mkdir /etc/nginx/ssl
    sudo ssh nginx chown nginx:nginx /etc/nginx/ssl
    sudo ssh nginx mkdir /etc/nginx/ssl-configs

# copy files to nginx

    sudo ssh nginx rm /etc/nginx/conf.d/default.conf
    sudo scp /tmp/hosts_nginx nginx:/etc/hosts
    sudo scp /tmp/juice.conf  nginx:/etc/nginx/conf.d/juice.conf

# update local hosts file on jump system
    sudo cp /tmp/hosts_jump /etc/hosts
 

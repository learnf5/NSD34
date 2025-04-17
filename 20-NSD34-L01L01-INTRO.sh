# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update lab environment
# pull files from github, prep directories on nginx and copy files to nginx
    cd /tmp
    git clone https://github.com/learnf5/nsd.git nsd_files
    sudo ssh nginx mkdir /etc/nginx/ssl
    sudo ssh nginx chown nginx:nginx /etc/nginx/ssl
    sudo ssh nginx mkdir /etc/nginx/ssl-configs
    sudo ssh nginx rm /etc/nginx/conf.d/default.conf
    sudo scp /tmp/nsd_files/INTRO/hosts_nginx nginx:/etc/hosts
    sudo scp /tmp/nsd_files/INTRO/juice.conf  nginx:/etc/nginx/conf.d/juice.conf

    # update local hosts file
    sudo mv /tmp/nsd_files/INTRO/hosts_jump /etc/hosts
 

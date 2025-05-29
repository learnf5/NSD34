# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update nginx host for the specific lab
# pull files from github
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/juice.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/juice_SecUp.bak
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/ssl-params.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/hosts_jump
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/hosts_nginx
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/SCRIPTS/create_certs.sh
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/SCRIPTS/curl_script.sh
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/SCRIPTS/upload.sh

    # IF don't need this backup file then delete it and the scp command below
        curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/proxy-ssl-params.bak    

# prepare files on nginx
    sudo ssh nginx rm /etc/nginx/conf.d/default.conf
    sudo ssh nginx mkdir -p /etc/nginx/ssl/DASHBOARD
    sudo ssh nginx chown --recursive nginx:nginx /etc/nginx/ssl
    sudo ssh nginx mkdir /etc/nginx/ssl-configs
    sudo ssh nginx mkdir -p /home/student/ssl/DASHBOARD
    sudo ssh nginx chown --recursive student:student /home/student/ssl

# copy files to nginx
    sudo scp /tmp/hosts_nginx nginx:/etc/hosts
    sudo scp /tmp/create_certs.sh nginx:/home/student/ssl/create_certs.sh
    sudo scp /tmp/create_certs.sh nginx:/etc/nginx/ssl/DASHBOARD/create_certs.sh
    sudo ssh nginx chmod +x /home/student/ssl/create_certs.sh
    sudo ssh nginx chmod +x /etc/nginx/ssl/DASHBOARD/create_certs.sh
    sudo ssh nginx chown student:student /home/student/ssl/create_certs.sh
    sudo scp /tmp/juice.conf nginx:/etc/nginx/conf.d/juice.conf
    sudo scp /tmp/ssl-params.conf nginx:/etc/nginx/ssl-configs/ssl-params.conf

    sudo scp /tmp/curl_script.sh            nginx:/home/student/curl_script.sh
    sudo ssh nginx chmod +x /home/student/curl_script.sh
    sudo ssh nginx chown student:student /home/student/curl_script.sh
  
    sudo scp /tmp/proxy-ssl-params.bak nginx:/etc/nginx/ssl-configs/proxy-ssl-params.bak    
    sudo scp /tmp/api_server.conf           nginx:/etc/nginx/SecureUpstreams/api_server.conf      

    # update local hosts file
    sudo mv /tmp/hosts_jump /etc/hosts

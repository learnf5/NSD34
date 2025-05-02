# Enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update lab environment

# pull github file, prepare nginx host and copy files to nginx host
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/SECURITY/juice.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/SECURITY/api_server.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/SECURITY/ssl-params.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/ssl-params.conf

    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/hosts_jump
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/hosts_nginx
  
    sudo ssh nginx rm /etc/nginx/conf.d/default.conf
    sudo ssh nginx mkdir /etc/nginx/ssl
    sudo ssh nginx chown --recursive nginx:nginx /etc/nginx/ssl
    sudo ssh nginx mkdir /etc/nginx/ssl-configs
    sudo ssh nginx mkdir /home/student/ssl
    sudo ssh nginx chown --recursive student:student /home/student/ssl
    sudo scp /tmp/hosts_nginx           nginx:/etc/hosts
    sudo scp /tmp/api_server.conf       nginx:/etc/nginx/conf.d/api_server.orig
    sudo scp /tmp/proxy-ssl-params.conf nginx:/etc/nginx/ssl-configs/proxy-ssl-params.conf
    sudo scp /tmp/dhparam.pem           nginx:/etc/nginx/dhparam.pem
    sudo scp /tmp/api_server.conf       nginx:/etc/nginx/conf.d/api_server.conf
    sudo scp /tmp/juice.conf            nginx:/etc/nginx/conf.d/juice.conf
    sudo scp /tmp/ssl-params.conf       nginx:/etc/nginx/ssl-configs/ssl-params.conf

    # Do we need these files???
    # curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/juice_SecUp.bak
    # curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/ssl-params-SecUp.conf
    # curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/ssl-params-SecUp.conf
    # curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/proxy-ssl-params.bak
    # curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/create_certs.sh
    # curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/curl_script.sh
    # curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/upload.sh

    # ADD these files back in once run lab ONCE and copy files to github 
    # config certs for nginx server on nginx host
    #sudo scp /tmp/ca-cert.crt                nginx:/etc/nginx/ssl/ca-cert.crt
    #sudo scp /tmp/ca-cert.crt                nginx:/home/student/ssl/ca-cert.crt
    #sudo scp /tmp/ca-cert.key                nginx:/home/student/ssl/ca-cert.key
    #sudo scp /tmp/ca-cert.srl                nginx:/home/student/ssl/ca-cert.srl
    #sudo scp /tmp/www.nginxtraining.com.crt  nginx:/etc/nginx/ssl/www.nginxtraining.com.crt
    #sudo scp /tmp/www.nginxtraining.com.crt  nginx:/home/student/ssl/www.nginxtraining.com.crt
    #sudo scp /tmp/www.nginxtraining.com.key  nginx:/etc/nginx/ssl/www.nginxtraining.com.key
    #sudo scp /tmp/www.nginxtraining.com.key  nginx:/home/student/ssl/www.nginxtraining.com.key
    #sudo scp /tmp/www.nginxtraining.com.csr  nginx:/home/student/ssl/www.nginxtraining.com.csr
    #sudo scp /tmp/ca-cert-dashboard.crt      nginx:/etc/nginx/ssl/ca-cert-dashboard.crt
    #sudo scp /tmp/www.nginxdashboard.com.crt nginx:/etc/nginx/ssl/www.nginxdashboard.com.crt
    #sudo scp /tmps/www.nginxdashboard.com.key nginx:/etc/nginx/ssl/www.nginxdashboard.com.key

    # update local hosts file
    sudo mv /tmp/nsd_files/INTRO/hosts_jump /etc/hosts
 

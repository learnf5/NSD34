# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update lab environment
# pull files from github, prep directories on nginx and copy files to nginx
# Lab 3 Exercise 1 Rate Limits
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/LIMITS/juice.conf    
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/LIMITS/ssl-params.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/LIMITS/api_server.conf
   
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/hosts_jump
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/hosts_nginx    
    
    # prepare nginx files and directories
    sudo ssh nginx rm /etc/nginx/conf.d/default.conf
    sudo ssh nginx mkdir /etc/nginx/ssl
    sudo ssh nginx chown --recursive nginx:nginx /etc/nginx/ssl
    sudo ssh nginx mkdir /etc/nginx/ssl-configs
    sudo ssh nginx mkdir /home/student/ssl
    sudo ssh nginx chown --recursive student:student /home/student/ssl
    sudo scp /tmp/hosts_nginx nginx:/etc/hosts
    sudo scp /tmp/api_server.conf nginx:/etc/nginx/conf.d/api_server.conf
    sudo scp /tmp/juice.conf nginx:/etc/nginx/conf.d/juice.conf
    sudo scp /tmp/ssl-params.conf nginx:/etc/nginx/ssl-configs/ssl-params.conf

    # Do not think we need these because will be created in lab
    #sudo scp /tmp/dhparam.pem nginx:/etc/nginx/dhparam.pem
    # sudo scp /tmp/api_server.conf nginx:/etc/nginx/conf.d/api_server.orig
    # sudo scp /tmp/proxy-ssl-params.conf nginx:/etc/nginx/ssl-configs/proxy-ssl-params.conf

    
    # configure certificates on host nginx
    #sudo scp /tmp/nsd_files/certs/ca-cert.crt nginx:/etc/nginx/ssl/ca-cert.crt
    #sudo scp /tmp/nsd_files/certs/ca-cert.crt nginx:/home/student/ssl/ca-cert.crt
    #sudo scp /tmp/nsd_files/certs/ca-cert.key nginx:/home/student/ssl/ca-cert.key
    #sudo scp /tmp/nsd_files/certs/ca-cert.srl nginx:/home/student/ssl/ca-cert.srl
    #sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.crt nginx:/etc/nginx/ssl/www.nginxtraining.com.crt
    #sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.crt nginx:/home/student/ssl/www.nginxtraining.com.crt
    #sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.key nginx:/etc/nginx/ssl/www.nginxtraining.com.key
    #sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.key nginx:/home/student/ssl/www.nginxtraining.com.key
    #sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.csr nginx:/home/student/ssl/www.nginxtraining.com.csr
    #sudo scp /tmp/nsd_files/certs/ca-cert-dashboard.crt nginx:/etc/nginx/ssl/ca-cert-dashboard.crt
    #sudo scp /tmp/nsd_files/certs/www.nginxdashboard.com.crt nginx:/etc/nginx/ssl/www.nginxdashboard.com.crt
    #sudo scp /tmp/nsd_files/certs/www.nginxdashboard.com.key nginx:/etc/nginx/ssl/www.nginxdashboard.com.key

# Lab 3 Exercise 2 Logs
## I don't think we need this file - I think lab steps have them create it and since we'll be using the same lab system it should be there
    #sudo scp /tmp/nsd_files/LIMITS/juice.PRElimits nginx:/etc/nginx/conf.d/juice.PRElimits

# Lab 3 Exercise 3 IP Deny
## I don't think we need any new files they should all be there because lab system is continuous now

# Lab 3 Exercise 4 IP Dynamic Lazy Certs
## I don't think we need any new files they should all be there because lab system is continuous now

    # update local hosts file
    sudo mv /tmp/nsd_files/INTRO/hosts_jump /etc/hosts
 

# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update lab environment
# pull files from github, prep directories on nginx and copy files to nginx
# Lab 3 Exercise 1 Rate Limits
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/LIMITS/juice.conf    
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/LIMITS/ssl-params.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/LIMITS/api_server.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/LIMITS/ssl-params-dashboard.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/LIMITS/proxy-ssl-params.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/hosts_jump
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/hosts_nginx
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/dhparam.pem
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/DASHBOARD/ca-cert-dashboard.crt
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/DASHBOARD/www.nginxdashboard.com.crt
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/DASHBOARD/www.nginxdashboard.com.key

    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/ca-cert.crt
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/www.nginxtraining.com.crt
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/www.nginxtraining.com.key

    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/SCRIPTS/create_certs.sh
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/SCRIPTS/curl_script.sh
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/SCRIPTS/upload.sh


    # prepare nginx files and directories
    sudo ssh nginx rm /etc/nginx/conf.d/default.conf
    sudo ssh nginx mkdir /etc/nginx/ssl
    sudo ssh nginx mkdir /etc/nginx/ssl/DASHBOARD
    sudo ssh nginx chown --recursive nginx:nginx /etc/nginx/ssl
    sudo ssh nginx mkdir /etc/nginx/ssl-configs
    sudo ssh nginx mkdir /home/student/ssl
    sudo ssh nginx mkdir /home/student/ssl/DASHBOARD
    sudo scp /tmp/hosts_nginx nginx:/etc/hosts
    sudo scp /tmp/api_server.conf nginx:/etc/nginx/conf.d/api_server.conf
    sudo scp /tmp/juice.conf nginx:/etc/nginx/conf.d/juice.conf
    sudo scp /tmp/ssl-params.conf nginx:/etc/nginx/ssl-configs/ssl-params.conf
    sudo scp /tmp/ssl-params-dashboard.conf nginx:/etc/nginx/ssl-configs/ssl-params-dashboard.conf
    sudo scp /tmp/create_certs.sh nginx:/home/student/ssl
    sudo scp /tmp/curl_script.sh nginx:/home/student/ssl
    sudo scp /tmp/upload.sh nginx:/home/student/ssl
     
    ###Certificate files for www.nginxtraining.com and www.nginxdashboard.com
    sudo scp /tmp/www.nginxtraining.com.crt nginx:/home/student/ssl
    sudo scp /tmp/www.nginxtraining.com.key nginx:/home/student/ssl
    sudo scp /tmp/ca-cert.crt nginx:/home/student/ssl

    sudo scp /tmp/www.nginxdashboard.com.crt nginx:/home/student/ssl/DASHBOARD
    sudo scp /tmp/www.nginxdashboard.com.key nginx:/home/student/ssl/DASHBOARD
    sudo scp /tmp/ca-cert-dashboard.crt nginx:/home/student/DASHBOARD/ca-cert.crt
    
    sudo ssh nginx chown --recursive student:student /home/student/ssl

    
    sudo scp /tmp/www.nginxtraining.com.crt nginx:/etc/nginx/ssl/
    sudo scp /tmp/www.nginxtraining.com.key nginx:/etc/nginx/ssl/
    sudo scp /tmp/ca-cert.crt nginx:/etc/nginx/ssl/
    
    sudo scp /tmp/www.nginxdashboard.com.crt nginx:/etc/nginx/ssl/DASHBOARD
    sudo scp /tmp/www.nginxdashboard.com.key nginx:/etc/nginx/ssl/DASHBOARD
    sudo scp /tmp/ca-cert-dashboard.crt nginx:/etc/nginx/ssl/DASHBOARD/ca-cert.crt

    sudo scp /tmp/dhparam.pem nginx:/etc/nginx/dhparam.pem
    sudo scp /tmp/proxy-ssl-params.conf nginx:/etc/nginx/ssl-configs/proxy-ssl-params.conf
    
    # if want original api_server.conf file without Dashboard and other things then copy from HTTPS to LIMITS folder and name it api_server.orig 
    # otherwise it will overwrite the updated file for this lab
    # sudo scp /tmp/api_server.conf nginx:/etc/nginx/conf.d/api_server.orig
    
    ###Certificate files for www.nginxtraining.com and www.nginxdashboard.com
    sudo scp /tmp/ca-cert.crt nginx:/etc/nginx/ssl/
    sudo scp /tmp/www.nginxtraining.com.crt nginx:/etc/nginx/ssl/
    sudo scp /tmp/www.nginxtraining.com.key nginx:/etc/nginx/ssl/

    sudo scp /tmp/ca-cert-dashboard.crt nginx:/etc/nginx/ssl/DASHBOARD/ca-cert-dashboard.crt
    sudo scp /tmp/www.nginxdashboard.com.crt nginx:/etc/nginx/ssl/DASHBOARD/www.nginxdashboard.com.crt
    sudo scp /tmp/www.nginxdashboard.com.key nginx:/etc/nginx/ssl/DASHBOARD/www.nginxdashboard.com.key

# Lab 3 Exercise 2 Logs
## I don't think we need this file - I think lab steps have them create it and since we'll be using the same lab system it should be there
    #sudo scp /tmp/nsd_files/LIMITS/juice.PRElimits nginx:/etc/nginx/conf.d/juice.PRElimits

# Lab 3 Exercise 3 IP Deny
## I don't think we need any new files they should all be there because lab system is continuous now

# Lab 3 Exercise 4 IP Dynamic Lazy Certs
## I don't think we need any new files they should all be there because lab system is continuous now

    # update local hosts file
    sudo mv /tmp/hosts_jump /etc/hosts
 

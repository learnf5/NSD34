# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update lab environment
# pull files from github, prepare nginx host and copy files to nginx host
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/API/juice.conf    
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/API/api_server.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/API/ssl-params.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/LIMITS/ssl-params-dashboard.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/LIMITS/proxy-ssl-params.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/dhparam.pem
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/hosts_jump
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/INTRO/hosts_nginx 
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/API/nginx.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/API/quotes.jwt
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/API/api_secret.jwk
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/API/LeesQuotes.jwt

    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/DASHBOARD/ca-cert-dashboard.crt
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/DASHBOARD/www.nginxdashboard.com.crt
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/DASHBOARD/www.nginxdashboard.com.key

    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/ca-cert.crt
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/www.nginxtraining.com.crt
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/CERTS/www.nginxtraining.com.key

        # Create directories on NGINX
    sudo ssh nginx mkdir /etc/nginx/ssl
    sudo ssh nginx mkdir -p /etc/nginx/ssl/DASHBOARD
    sudo ssh nginx mkdir -p /etc/nginx/ssl-configs
    sudo ssh nginx mkdir /home/student/ssl
    sudo ssh nginx mkdir -p /home/student/ssl/DASHBOARD
    
    sudo ssh nginx rm /etc/nginx/conf.d/default.conf
    sudo scp /tmp/hosts_nginx nginx:/etc/hosts
    sudo scp /tmp/ssl-params.conf nginx:/etc/nginx/ssl-configs/ssl-params.conf
    sudo scp /tmp/ssl-params-dashboard.conf nginx:/etc/nginx/ssl-configs/ssl-params-dashboard.conf
    sudo scp /tmp/proxy-ssl-params.conf nginx:/etc/nginx/ssl-configs/proxy-ssl-params.conf
    sudo scp /tmp/dhparam.pem nginx:/etc/nginx/dhparam.pem
    sudo scp /tmp/api_server.conf nginx:/etc/nginx/conf.d/api_server.conf
    sudo scp /tmp/juice.conf nginx:/etc/nginx/conf.d/juice.conf
    sudo scp /tmp/nginx.conf nginx:/etc/nginx/nginx.conf
    sudo scp /tmp/quotes.jwt nginx:/home/student/
    sudo scp /tmp/api_secret.jwk nginx:/home/student/
    sudo scp /tmp/LeesQuotes.jwt nginx:/home/student/


  ###Certificate files for www.nginxtraining.com and www.nginxdashboard.com
  
    sudo scp /tmp/ca-cert.crt nginx:/etc/nginx/ssl/
    sudo scp /tmp/www.nginxtraining.com.crt nginx:/etc/nginx/ssl/
    sudo scp /tmp/www.nginxtraining.com.key nginx:/etc/nginx/ssl/

    sudo scp /tmp/ca-cert-dashboard.crt nginx:/etc/nginx/ssl/DASHBOARD/ca-cert.crt
    sudo scp /tmp/www.nginxdashboard.com.crt nginx:/etc/nginx/ssl/DASHBOARD/www.nginxdashboard.com.crt
    sudo scp /tmp/www.nginxdashboard.com.key nginx:/etc/nginx/ssl/DASHBOARD/www.nginxdashboard.com.key

    sudo scp /tmp/ca-cert.crt nginx:/home/student/ssl/
    sudo scp /tmp/www.nginxtraining.com.crt nginx:/home/student/ssl/
    sudo scp /tmp/www.nginxtraining.com.key nginx:/home/student/ssl

    sudo ssh nginx chown --recursive student:student /home/student/ssl
    sudo ssh nginx chown --recursive nginx:nginx /etc/nginx/ssl

    # update local hosts files
    sudo mv /tmp/hosts_jump /etc/hosts
 

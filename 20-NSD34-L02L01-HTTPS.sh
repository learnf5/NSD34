# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update nginx host for the specific lab
# pull files from github
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/juice.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/juice_SecUp.bak
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/api_server.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/ssl-params.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/ssl-params-SecUp.conf
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/proxy-ssl-params.bak
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/hosts_jump
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/hosts_nginx
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/create_certs.sh
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/curl_script.sh
    curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/HTTPS/upload.sh

# prepare files on nginx
    sudo ssh nginx rm /etc/nginx/conf.d/default.conf
    sudo ssh nginx mkdir /etc/nginx/ssl
    sudo ssh nginx chown --recursive nginx:nginx /etc/nginx/ssl
    sudo ssh nginx mkdir /etc/nginx/ssl-configs
    sudo ssh nginx mkdir /home/student/ssl
    sudo ssh nginx chown --recursive student:student /home/student/ssl

# copy files to nginx
    sudo scp /tmp/hosts_nginx nginx:/etc/hosts
    sudo scp /tmp/create_certs.sh nginx:/home/student/ssl/create_certs.sh
    sudo ssh nginx chmod +x /home/student/ssl/create_certs.sh
    #probably don't need to change ownership since done earlier...
    sudo ssh nginx chown student:student /home/student/ssl/create_certs.sh
    sudo scp /tmp/juice.conf nginx:/etc/nginx/conf.d/juice.conf
    sudo scp /tmp/ssl-params.conf nginx:/etc/nginx/ssl-configs/ssl-params.conf

# prep directories on nginx

 ####   FOR COMBINING L201-HTTPS & L02L02-SecUp - make sure whatever did in L2L01-HTTPS works for start up of SecUp
 ####   COULD create new directory /etc/nginx/SecUp and put the files that were used in Securing Upstream there 
 ####   which I'm calling SecUp_filename.bak...and then either copy the file need to /etc/nginx/conf.d/ or add in with include directive
 # pull files from github, prep directories on nginx and copy files to nginx
    sudo scp /tmp/curl_script.sh            nginx:/home/student/curl_script.sh
    sudo ssh nginx chmod +x /home/student/curl_script.sh
    sudo ssh nginx chown student:student /home/student/curl_script.sh
   #### NEED TO ADD STEP TO LAB to rename SecUp_juice.bak to juice.conf OR just the steps to add what we need to juice.conf
    sudo scp /tmp/SecUp_juice.conf      nginx:/etc/nginx/conf.d/SecUp_juice.bak
   #### NEED TO ADD STEP TO LAB to rename SecUp_api_server.bak to api_server.conf.conf 
    sudo scp /tmp/SecUp_api_server.bak       nginx:/etc/nginx/conf.d/SecUp_api_server.bak
  #### NEED TO ADD STEP TO LAB to rename proxy-ssl-params.bak to SecUp-proxy-ssl-params.conf.conf
    sudo scp /tmp/SecUp_ssl-params.bak       nginx:/etc/nginx/ssl-configs/SecUp_ssl-params.bak
  #### NEED TO ADD STEP TO LAB to rename SecUp_proxy-ssl-params.bak to SecUp_proxy-ssl-params.conf 
   # sudo scp /tmp/nsd_files/HTTPS/proxy-ssl-params.conf nginx:/etc/nginx/ssl-configs/proxy-ssl-params.conf    
   sudo scp /tmp/SecUp_proxy-ssl-params.bak nginx:/etc/nginx/ssl-configs/SecUp_proxy-ssl-params.bak    
 
  #### NEED TO ADD STEP TO LAB to rename SecUp_dhparam.pem to dhparam.pem 
  #### PROBABLY don't need this since they will have created this file in part 1 of lab 2
  # sudo scp /tmp/SecUp_dhparam.pem           nginx:/etc/nginx/SecUp_dhparam.pem

#### OR MAYBE A SIMPLER SETUP, create a new directory /etc/nginx/SecureUpstreams
  #  sudo ssh nginx mkdir /etc/nginx/SecureUpstreams
  #  sudo scp /tmp/juice.conf               nginx:/etc/nginx/SecureUpstreams/juice.conf
  # sudo scp /tmp/api_server.conf           nginx:/etc/nginx/SecureUpstreams/api_server.conf
  # sudo scp /tmp/ssl-params.conf           nginx:/etc/nginx/SecureUpstreams/ssl-params.conf
  # sudo scp /tmp/proxy-ssl-params.conf     nginx:/etc/nginx/SecureUpstreams/proxy-ssl-params.conf    
     
#### PROBABLY don't need this since they will have created this file in part 1 of lab 2
    #sudo scp /tmp/nsd_files/HTTPS/dhparam.pem           nginx:/etc/nginx/SecureUpstreams/dhparam.pem
    
    # copy cert files to nginx
    ##### PROBABLY DON'T NEED THESE FILES SINCE create in part 1 of Lab2 HTTPS
    #sudo scp /tmp/nsd_files/certs/ca-cert.crt                nginx:/etc/nginx/ssl/ca-cert.crt
    #sudo scp /tmp/nsd_files/certs/ca-cert.crt                nginx:/home/student/ssl/ca-cert.crt
    #sudo scp /tmp/nsd_files/certs/ca-cert.key                nginx:/home/student/ssl/ca-cert.key
    #sudo scp /tmp/nsd_files/certs/ca-cert.srl                nginx:/home/student/ssl/ca-cert.srl
    #sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.crt  nginx:/etc/nginx/ssl/www.nginxtraining.com.crt
    #sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.crt  nginx:/home/student/ssl/www.nginxtraining.com.crt
    #sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.key  nginx:/etc/nginx/ssl/www.nginxtraining.com.key
    #sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.key  nginx:/home/student/ssl/www.nginxtraining.com.key
    #sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.csr  nginx:/home/student/ssl/www.nginxtraining.com.csr
    #sudo scp /tmp/nsd_files/certs/ca-cert-dashboard.crt      nginx:/etc/nginx/ssl/ca-cert-dashboard.crt
    #sudo scp /tmp/nsd_files/certs/www.nginxdashboard.com.crt nginx:/etc/nginx/ssl/www.nginxdashboard.com.crt
    #sudo scp /tmp/nsd_files/certs/www.nginxdashboard.com.key nginx:/etc/nginx/ssl/www.nginxdashboard.com.key    

    # update local hosts file
    sudo mv /tmp/hosts_jump /etc/hosts

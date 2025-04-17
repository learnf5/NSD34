# Enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update lab environment

# pull github file, prepare nginx host and copy files to nginx host
    cd /tmp
    git clone https://github.com/learnf5/nsd.git nsd_files
    sudo ssh nginx rm /etc/nginx/conf.d/default.conf
    sudo ssh nginx mkdir /etc/nginx/ssl
    sudo ssh nginx chown --recursive nginx:nginx /etc/nginx/ssl
    sudo ssh nginx mkdir /etc/nginx/ssl-configs
    sudo ssh nginx mkdir /home/student/ssl
    sudo ssh nginx chown --recursive student:student /home/student/ssl
    sudo scp /tmp/nsd_files/L1-L1-Intro/hosts_nginx           nginx:/etc/hosts
    sudo scp /tmp/nsd_files/L2-L2-SecUp/api_server.conf       nginx:/etc/nginx/conf.d/api_server.orig
    sudo scp /tmp/nsd_files/L2-L2-SecUp/proxy-ssl-params.conf nginx:/etc/nginx/ssl-configs/proxy-ssl-params.conf
    sudo scp /tmp/nsd_files/L2-L2-SecUp/dhparam.pem           nginx:/etc/nginx/dhparam.pem
    sudo scp /tmp/nsd_files/L5-L1-HTTP2/api_server.conf       nginx:/etc/nginx/conf.d/api_server.conf
    sudo scp /tmp/nsd_files/L5-L1-HTTP2/juice.conf            nginx:/etc/nginx/conf.d/juice.conf
    sudo scp /tmp/nsd_files/L5-L1-HTTP2/ssl-params.conf       nginx:/etc/nginx/ssl-configs/ssl-params.conf

    # config certs for nginx server on nginx host
    sudo scp /tmp/nsd_files/certs/ca-cert.crt                nginx:/etc/nginx/ssl/ca-cert.crt
    sudo scp /tmp/nsd_files/certs/ca-cert.crt                nginx:/home/student/ssl/ca-cert.crt
    sudo scp /tmp/nsd_files/certs/ca-cert.key                nginx:/home/student/ssl/ca-cert.key
    sudo scp /tmp/nsd_files/certs/ca-cert.srl                nginx:/home/student/ssl/ca-cert.srl
    sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.crt  nginx:/etc/nginx/ssl/www.nginxtraining.com.crt
    sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.crt  nginx:/home/student/ssl/www.nginxtraining.com.crt
    sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.key  nginx:/etc/nginx/ssl/www.nginxtraining.com.key
    sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.key  nginx:/home/student/ssl/www.nginxtraining.com.key
    sudo scp /tmp/nsd_files/certs/www.nginxtraining.com.csr  nginx:/home/student/ssl/www.nginxtraining.com.csr
    sudo scp /tmp/nsd_files/certs/ca-cert-dashboard.crt      nginx:/etc/nginx/ssl/ca-cert-dashboard.crt
    sudo scp /tmp/nsd_files/certs/www.nginxdashboard.com.crt nginx:/etc/nginx/ssl/www.nginxdashboard.com.crt
    sudo scp /tmp/nsd_files/certs/www.nginxdashboard.com.key nginx:/etc/nginx/ssl/www.nginxdashboard.com.key

    # restart nginx server on nginx host
    sudo ssh nginx nginx -s stop
    sudo ssh nginx nginx

    # update local hosts file
    sudo mv /tmp/nsd_files/L1-L1-Intro/hosts_jump /etc/hosts
 

# install 30 day nginx one trial licenses from Salesforce - EXPIRES May 22, 2025
set +x
curl --silent --remote-name-all --output-dir /tmp --header "Authorization: token $TOKEN" https://raw.githubusercontent.com/learnf5/eval-reg-keys/main/nginx/EXPIRES-May-22-2025/nginx-one-eval.{crt,key,jwt}
echo curl --silent --remote-name-all --output-dir /tmp --header "Authorization: token xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" https://raw.githubusercontent.com/learnf5/eval-reg-keys/main/nginx/EXPIRES-May-22-2025/nginx-one-eval.{crt,key,jwt}
set -x
until sudo scp /tmp/nginx-one-eval.crt nginx:/etc/ssl/nginx/nginx-repo.crt || (( count++ > 5 )); do sleep 5; done
until sudo scp /tmp/nginx-one-eval.key nginx:/etc/ssl/nginx/nginx-repo.key || (( count++ > 5 )); do sleep 5; done
until sudo scp /tmp/nginx-one-eval.jwt nginx:/etc/nginx/license.jwt || (( count++ > 5 )); do sleep 5; done

# restart NGINX
sudo ssh nginx sudo systemctl stop nginx
sudo ssh nginx sudo systemctl start nginx

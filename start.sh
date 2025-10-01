
sudo docker stop $(sudo docker ps -a -q)
sudo docker remove $(sudo docker ps -a -q)
sudo docker-compose up -d
sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubuntu2204_users


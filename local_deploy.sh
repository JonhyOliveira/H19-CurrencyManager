docker-compose -f docker-compose.yml build 
rm -f ./rails_app/tmp/pids/server.pid # remove pid, just in case
docker-compose -f docker-compose.yml up
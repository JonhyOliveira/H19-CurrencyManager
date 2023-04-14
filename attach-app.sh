_PWD=$(pwd | tr "/" " ")

APP=${_PWD##* }-rails_app-1

echo "Attaching to $APP"
echo

docker exec -it $APP /bin/bash
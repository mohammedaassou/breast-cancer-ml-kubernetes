
# set -euo pipefail

set -euo pipefail


docker build -t bc-trainer:1.0 ../app/trainer
docker build -t bc-api:1.0 --build-arg APP_VERSION=1.0 ../app/api
docker build -t bc-api:2.0 --build-arg APP_VERSION=2.0 ../app/api
docker build -t bc-front:1.0 ../app/front

for img in bc-trainer:1.0 bc-api:1.0 bc-api:2.0 bc-front:1.0; do
    echo ">> minikube image load $img"
    minikube image load "$img"
done

minikube image ls | grep "bc-"
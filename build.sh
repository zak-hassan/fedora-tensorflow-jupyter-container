IMAGE_NAME=fedora-28-tf2.0
REPO_URL=quay.io/zmhassan/fedora28-tensorflow2.0-cpu
docker build --rm -t  $IMAGE_NAME  .
docker tag  $IMAGE_NAME $REPO_URL
docker push  $REPO_URL


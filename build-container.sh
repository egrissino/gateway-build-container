
USER=$(whoami)
ARCH=$(arch)
yoctoDir=/home/$USER/yoctoworkspace

if [[ ! -d "$yoctoDir" ]]; then
    mkdir -p $yoctoDir
fi

docker stop gateway-build-image-${USER}
docker remove gateway-build-image-${USER}
docker rmi gateway-build-image:Dockerfile

docker buildx build \
    --platform=linux/amd64 \
    --build-arg USERNAME=$(whoami) \
    -t "gateway-build-image:Dockerfile" .


imageId=$(docker images -q gateway-build-image)

if [[ $imageId == "" ]]; then
    echo "Failed to build image"
else
    docker run -d \
        --name="gateway-build-image-$USER" \
        --volume $yoctoDir:$yoctoDir \
        -t gateway-build-image:Dockerfile
fi
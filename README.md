# docker_firefox
Run Firefox with GUI inside a container

# Get the source
```
git clone https://github.com/cslev/docker_firefox
```

# Install Docker environment
Do it on your own, many sources are available via Google

# Build image
```
cd docker_firefox
sudo docker build -t docker_firefox .
```

# Run image with GUI
Here, we need to pass some local X11 variables and files to the container to make it able to run GUI apps
```
sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" docker_firefox
```

## Possible errors
There are good descriptions and comments [here](https://medium.com/@SaravSun/running-gui-applications-inside-docker-containers-83d65c0db110)

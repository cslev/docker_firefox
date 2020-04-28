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
sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" docker_firefox /docker_firefox/firefox/firefox
```

If Firefox does not show up, run any other x11-apps (for testing) or `xterm` and run `firefox` within `xterm`.
```
$ sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" docker_firefox xterm

in xterm:
$ /docker_firefox/firefox/firefox

```

## Special needs
By defining `--net=host`, we let our container to see the root networking namespace, which is not always the case we want. However, for accessing all X11 sockets it is important, but there is a workaround.

Now, let's assume a bit more extreme case where we don't want any docker networking at all as we will connect it manually, say, to an Open vSwitch.
```
sudo docker run -dit --name=docker_firefox --net=none -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/root/.Xauthority --hostname $(hostname) cslev/docker_firefox:selenium "xterm -fn 10x20"
```
For simplicity, here we start an xterm where you can start your firefox from! Use the previous command's path to firefox if you want to start it first.

## Possible errors
There are good descriptions and comments [here](https://medium.com/@SaravSun/running-gui-applications-inside-docker-containers-83d65c0db110)

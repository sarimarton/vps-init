# My VPS

## Installation

Don't forget to clone this project with --recursive:

```
git clone --recurse-submodules https://github.com/sarimarton/vps-init.git
```

or get the submodules after clone, before building:

```
git submodule update --init
```

## Run

```
git clone --recurse-submodules https://github.com/sarimarton/vps-init.git
docker build -t vacskamati.hu vacskamati.hu
docker build -t sm-lang sm-lang
docker-compose up
```

# My VPS

## Installation

Clone the project with the submodules:

```
git clone --recurse-submodules https://github.com/sarimarton/vps-init.git
```

Then build the images:

```
docker build -t vacskamati.hu vacskamati.hu
docker build -t sm-lang sm-lang
```

## Run

```
docker-compose up
```

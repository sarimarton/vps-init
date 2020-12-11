# My VPS

## Installation

Clone the project with the submodules:

```
git clone --recurse-submodules https://github.com/sarimarton/vps-init.git
```

Then build/run on dev:

```
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d --build
```

Then build/run on prod:

```
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build
```

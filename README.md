# Duplicacy-Docker

This is a Docker image for running [Duplicacy](https://duplicacy.com/), a cross-platform cloud backup tool. At this time, the newest version of Duplicacy is 1.7.2.

## Usage
Configure the provided [docker-compose.yml](./docker-compose.yml) file to run the container:

```bash
docker-compose up -d
```

The app will then be available at [http://localhost:3875](http://localhost:3875).

## Configuration
The container is configured using environment variables.

`MACHINE_ID`: This is the ID of your machine. It is used for licensing purposes. If an ID is not provided, the container will generate one for you and print it to the console. You can then set it as an environment variable and use it for future runs.

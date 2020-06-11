# Snipe-IT Quick

For quick development and testing of [Snipe-IT Asset Management](https://snipeitapp.com/).

## Usage

1. `make default`
2. Visit in a private browser: http://127.0.0.1:3051
3. Step through wizard*
4. Do it to it
5. `make clean`

**Note: You will get an error if you visit setup with existing session cookies.*

### Set Rate Limit Throttle

It’s not possible to modify the rate limit throttle with environment config.

```console
$ make snipe-it-throttle limit=120
```

## Requirements

- docker-compose
- make

## References

- https://snipeitapp.com/
- https://github.com/snipe/snipe-it
- https://snipe-it.readme.io/docs/docker
- https://hub.docker.com/r/snipe/snipe-it
- https://hub.docker.com/_/mysql/
- https://github.com/vishnubob/wait-for-it

# Minimal Docker image running fpm

Use this image as follows

```
docker run -v "$(pwd)":/src tcassaert/fpm-builder
```

The `CMD` for the container is `/src/fpm.sh`. So make a shell script i`fpm.sh` in the current directory that calls the fpm command with its options. 

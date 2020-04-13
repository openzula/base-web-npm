# openzula/base-web-npm
This Docker image is most likely not useful to anybody except for us! It provides a base image to build web assets that
get installed with NPM and generated through webpack/gulp etc.

## Prerequisites
There are no prerequisites.

## Deployment
This image is intended to be used as a base only and not to be ran directly. Instead you should create and build your
own image using our standard directory structure as follows:

```
./build
-- aws
---- web.dockerfile
./src
-- resources
---- assets
------ css
------ js
-- package.json
```

This base image is intended to be used as part of a multi-stage Dockerfile, whereby this image will be responsible for
building the static assets as required. These static assets would then be copied from this image. For example:

```dockerfile
# Build the assets 
FROM openzula/base-web-assets:latest AS assets
COPY src/webpack.mix.js
COPY src/resources/assets/ resources/assets/
RUN npm run production

# Use base Nginx webserver with static assets
FROM openzula/base-web-nginx:latest
COPY ./src/public/ /var/www/public/
COPY --from=assets /usr/src/app/public/dist/ /var/www/public/dist/
```

Then build the image by running the following command in the top most directly of your project:

```shell script
docker build -f build/aws/web.dockerfile -t example/web .
```

## Configuration
There are no environmental variables to configure this image.

## License
This project is licensed under the BSD 3-clause license - see [LICENSE.md](LICENSE.md) file for details.

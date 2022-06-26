### STAGE 1: Build Container ###
FROM node:12-alpine as builder

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apk update && apk upgrade

COPY . /usr/src/app/

RUN npm install
RUN npm run build
RUN npm run generate

### STAGE 2: NGINX ###
FROM nginx:1.21.1-alpine

COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
COPY --from=builder /usr/src/app/nginx.conf /etc/nginx/conf.d/default.conf


